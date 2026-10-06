devops@anlinh:~/ss06/ex04$ cd ~/ss06/ex04

cat > README.md <<'ENDREADME'
# Bài 4 - Quản lý tiến trình nền với nohup và tín hiệu Kill

## 1. Khởi chạy tiến trình

```bash
chmod +x loop-monitor.sh
nohup ./loop-monitor.sh >/tmp/loop-monitor-nohup.log 2>&1 &
echo $! | tee /tmp/loop-monitor.pid
> ^C
devops@anlinh:~/ss06/ex04$ cat loop-monitor.sh
#!/usr/bin/env bash

LOG_FILE="/tmp/monitor.log"

stop_monitor() {
    echo "Monitor stopped at: $(date)" >> "$LOG_FILE"
    exit 0
}

trap stop_monitor SIGTERM SIGINT

while true; do
    echo "System time: $(date)" >> "$LOG_FILE"
    sleep 5
done
devops@anlinh:~/ss06/ex04$ ls -l loop-monitor.sh
-rwxrwxr-x 1 devops devops 248 Oct  6 16:29 loop-monitor.sh
devops@anlinh:~/ss06/ex04$ cat /tmp/loop-monitor.pid
122715
devops@anlinh:~/ss06/ex04$ PID=$(cat /tmp/loop-monitor.pid)
devops@anlinh:~/ss06/ex04$ ps -o "$PID"
error: unknown user-defined format specifier "122715"

Usage:
 ps [options]

 Try 'ps --help <simple|list|output|threads|misc|all>'
  or 'ps --help <s|l|o|t|m|a>'
 for additional help text.

For more details see ps(1).
devops@anlinh:~/ss06/ex04$ ps -p "$PID"
    PID TTY          TIME CMD
devops@anlinh:~/ss06/ex04$ pgrep -af loop-monitor.sh || echo "Khong con tien trinh loop-monitor.sh"
Khong con tien trinh loop-monitor.sh
devops@anlinh:~/ss06/ex04$ tail -n 10 /tmp/monitor.log
System time: Tue Oct  6 16:30:36 +07 2026
System time: Tue Oct  6 16:30:41 +07 2026
System time: Tue Oct  6 16:30:46 +07 2026
System time: Tue Oct  6 16:30:51 +07 2026
System time: Tue Oct  6 16:30:56 +07 2026
System time: Tue Oct  6 16:31:01 +07 2026
System time: Tue Oct  6 16:31:06 +07 2026
System time: Tue Oct  6 16:31:11 +07 2026
System time: Tue Oct  6 16:31:16 +07 2026
Monitor stopped at: Tue Oct  6 16:31:21 +07 2026
devops@anlinh:~/ss06/ex04$ 
