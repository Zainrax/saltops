#############################################################
# Ensure that salt-updater is installed, configured & running
#############################################################

salt-updater-pkg:
  cacophony.pkg_installed_from_github:
    - name: salt-updater
    - version: "0.6.1"

salt-updater:
  service.running:
    - enable: True
    - watch:
      - salt-updater-pkg
