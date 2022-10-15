package net.niuxiaoer.flutter_jihuoniao.util

import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodChannel

object GlobalData {
    lateinit var messenger: BinaryMessenger

    lateinit var splashAdResult: MethodChannel.Result
}