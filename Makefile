ZIP_NAME := magisk_module.zip
VERSION_CODE := git-$(shell TZ=UTC git log -1 --date=format:'%Y%m%d-%H%M%S' --format='%ad')

all: clean
	@echo "Updating versionCode to $(VERSION_CODE)..."
	@sed -i "s/^versionCode=.*/versionCode=$(VERSION_CODE)/" module.prop
	@echo "Creating Magisk flashable zip..."
	@zip -r "$(ZIP_NAME)" . -x "$(ZIP_NAME)" "Makefile" ".*"
	@echo "Done: $(ZIP_NAME)"

install:
	@echo "Installing Magisk module..."
	@adb push "$(ZIP_NAME)" /data/local/tmp/
	@adb shell su -c 'magisk --install-module /data/local/tmp/$(ZIP_NAME)'
	@echo "Installation complete."

clean:
	@rm -f "$(ZIP_NAME)"
	@echo "Cleaned up."
