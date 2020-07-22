
echo "
[module/notification]
type = custom/ipc

hook-0 = echo \"\"
hook-1 = cat /tmp/notification

format = <output>
initial = 1
"
