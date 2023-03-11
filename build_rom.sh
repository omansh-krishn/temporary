# sync rom
repo init --depth=1 --no-repo-verify -u https://github.com/PixelExperience/manifest.git -b thirteen-plus -g default,-mips,-darwin,-notdefault
git clone https://github.com/omansh-krishn/local_manifest.git -b pe .repo/local_manifests
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j8
# @omansh_krishn
# modified hardware_custom_compat
# build rom

source build/envsetup.sh
export ALLOW_MISSING_DEPENDENCIES=true
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true
export TZ=Asia/Kolkata # put before last build command
lunch aosp_santoni-userdebug
mka bacon
#rebuild

# upload rom (if you don't need to upload multiple files, then you don't need to edit next line)
#rclone copy out/target/product/santoni/recovery.img cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
rclone copy out/target/product/$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1)/*.zip cirrus:$(grep unch $CIRRUS_WORKING_DIR/build_rom.sh -m 1 | cut -d ' ' -f 2 | cut -d _ -f 2 | cut -d - -f 1) -P
