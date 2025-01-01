ARCHIVE_DIR="/mnt/sda5/mariadb-logs"
MAX_SIZE=100000000
MAX_ARCHIVES=2
DB_USER="root"


while true; do
    if [ -f "$LOG_FILE" ]; then
        FILE_SIZE=$(stat -c%s "$LOG_FILE")

        if [ "$FILE_SIZE" -gt "$MAX_SIZE" ]; then
            TIMESTAMP=$(date +%Y%m%d_%H%M%S)

            mv "$LOG_FILE" "$ARCHIVE_DIR/mysql-general.log.$TIMESTAMP"

            mysql -u "$DB_USER" -e "FLUSH GENERAL LOGS;" 2>> "$ARCHIVE_DIR/rotate.log"

            touch "$LOG_FILE"
            chown mysql:mysql "$LOG_FILE"
            chmod 640 "$LOG_FILE"

            cd "$ARCHIVE_DIR"
            ARCHIVES_COUNT=$(ls -1 mysql-general.log.* | wc -l)

            if [ "$ARCHIVES_COUNT" -gt "$MAX_ARCHIVES" ]; then
                ls -1t mysql-general.log.* | tail -n +3 | xargs rm -f
            fi

            echo "$(date): LOG File Archived and new created" >> "$ARCHIVE_DIR/rotate.log"
        fi
    else
        echo "$(date): no log file found !" >> "$ARCHIVE_DIR/rotate.log"
    fi

    sleep 30
done
