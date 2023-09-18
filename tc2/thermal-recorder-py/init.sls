/etc/dbus-1/system.d/org.cacophony.thermalrecorder.conf:
   file.managed:
     - source: salt://tc2/thermal-recorder-py/org.cacophony.thermalrecorder.conf

/etc/systemd/system/thermal-recorder-py.service:
   file.managed:
     - source: salt://tc2/thermal-recorder-py/thermal-recorder-py.service

/usr/bin/update-thermal-recorder-py-git:
  file.managed:
    - source: salt://tc2/thermal-recorder-py/update-thermal-py-recorder-git
    - mode: 755

'update-thermal-recorder-py-git':
  cmd.run

thermal-recorder-py-service:
  service.running:
    - name: thermal-recorder-py
    - enable: True

'download-model v0.1':
  cmd.run
