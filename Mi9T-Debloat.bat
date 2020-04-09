adb devices
TIMEOUT 15
adb devices
adb shell pm uninstall -k --user 0 com.android.browser
adb shell pm uninstall -k --user 0 com.miui.analytics
adb shell pm uninstall -k --user 0 com.facebook.appmanager
adb shell pm uninstall -k --user 0 com.facebook.system
adb shell pm uninstall -k --user 0 com.google.android.apps.wellbeing
adb shell pm uninstall -k --user 0 com.facebook.services
adb shell pm uninstall -k --user 0 com.xiaomi.glgm
adb shell pm uninstall -k --user 0 com.miui.fm
adb shell pm uninstall -k --user 0 com.xiaomi.mipicks
adb shell pm uninstall -k --user 0 com.google.android.googlequicksearchbox
adb shell pm uninstall -k --user 0 com.google.ar.lens
adb shell pm uninstall -k --user 0 com.xiaomi.payment
adb shell pm uninstall -k --user 0 com.android.calendar
adb shell pm uninstall -k --user 0 com.mipay.wallet.id
adb shell pm uninstall -k --user 0 com.mipay.wallet.in
adb shell pm uninstall -k --user 0 com.miui.player
adb shell pm uninstall -k --user 0 com.miui.notes
adb shell pm uninstall -k --user 0 com.miui.weather2
adb shell pm uninstall -k --user 0 com.xiaomi.midrop
adb shell pm uninstall -k --user 0 com.google.android.youtube
adb shell pm uninstall -k --user 0 com.mi.android.globalFileexplorer
adb shell pm uninstall -k --user 0 com.miui.screenrecorder
adb shell pm uninstall -k --user 0 com.miui.cloudservice.sysbase
adb shell pm uninstall -k --user 0 com.miui.cloudservice
adb shell pm uninstall -k --user 0 com.miui.cloudbackup
adb shell pm uninstall -k --user 0 com.miui.miservice
adb shell pm uninstall -k --user 0 com.android.soundrecorder
adb shell pm uninstall -k --user 0 com.miui.compass
adb shell pm uninstall -k --user 0 com.miui.videoplayer
adb shell pm uninstall -k --user 0 com.xiaomi.miplay_client
adb shell pm uninstall -k --user 0 com.xiaomi.joyose
adb shell pm uninstall -k --user 0 com.miui.micloudsync
adb shell pm uninstall -k --user 0 com.android.providers.downloads.ui
PAUSE
echo "All done!"