MariaDB General Log Rotation Script
This script is designed to handle the rotation of the MariaDB general log file efficiently. It solves common issues faced when using the general_log feature in MariaDB, especially in high-traffic environments where log files grow rapidly.

Problem
General Log Disabled: Without the general log enabled, troubleshooting becomes difficult since it's not possible to track queries that could cause issues.
Log File Growth: When the general_log is enabled, the log file grows very quickly, especially when there are many users and high transaction volume.
Logrotate Issues: The typical logrotate solution doesn't work well because MariaDB keeps the log file open and doesn't close it after rotating, which makes it ineffective.
Solution
To address these challenges, I wrote a bash script that:

Checks the log file size every 30 seconds.
Archives the log file if it exceeds 100MB.
Creates a new log file and forces MariaDB to write to the new log file.
Limits the number of archived logs to 2.
This ensures that the log files are kept manageable, and MariaDB can continue writing logs without issues.

Features
Dynamic configuration: All variables are defined dynamically, making it easy to change parameters as needed.
Automatic log file management: Archives the log file and creates a new one when it exceeds the specified size.
Easy to implement and configure for MariaDB servers with high traffic and transaction volume.
Keeps only the most recent 2 archived logs to prevent storage issues.
