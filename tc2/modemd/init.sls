dnsutils:
  pkg.installed: []

modemd-pkg:
  cacophony.pkg_installed_from_github:
    - name: modemd
    - version: "1.7.5-tc2"

modemd:
  service.running:
    - enable: True
    - watch:
      - modemd-pkg