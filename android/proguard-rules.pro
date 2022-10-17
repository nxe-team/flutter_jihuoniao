-keep public class com.ads.sdk.api.**{ *;}
-keep class com.ads.sdk.config.AdConfig{ *;}
-keep public class com.jihuoniao.sdk.**{ *;}
-keep public class com.ads.device.**{ *;}
-keep class com.ads.sdk.config.AdConfig$*{
        <fields>;
        <methods>;
}
-keep public class com.ads.sdk.net.model.**{ *;}
-keep public class com.ads.sdk.channel.**.Budget{
      public <methods>;
}
-keep public class com.ads.sdk.channel.methodproxy**{
      public <methods>;
}
-dontwarn com.bun.**
-keep class com.bun.** {*;}
-keep class a.**{*;}
-keep class XI.CA.XI.**{*;}
-keep class XI.K0.XI.**{*;}
-keep class XI.XI.K0.**{*;}
-keep class XI.vs.K0.**{*;}
-keep class XI.xo.XI.XI.**{*;}
-keep class com.asus.msa.SupplementaryDID.**{*;}
-keep class com.asus.msa.sdid.**{*;}
-keep class com.huawei.hms.ads.identifier.**{*;}
-keep class com.samsung.android.deviceidservice.**{*;}
-keep class com.zui.opendeviceidlibrary.**{*;}
-keep class org.json.**{*;}
-keep public class com.netease.nis.sdkwrapper.Utils {public <methods>;}
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable*Annotation*,EnclosingMethod
-keep class com.bytedance.sdk.openadsdk.** {*;}
-keep public interface com.bytedance.sdk.openadsdk.downloadnew.** {*;}
-keep class com.pgl.sys.ces.* {*;}
-keep class org.chromium.** {*;}
-keep class org.chromium.** { *; }
-keep class aegon.chrome.** { *; }
-keep class com.kwai.**{ *; }
-dontwarn com.kwai.**
-dontwarn com.kwad.**
-dontwarn com.ksad.**
-dontwarn aegon.chrome.**
-keep class pro.dxys.ad.**{*;}
-keep class com.taobao.**{*; }

-dontoptimize
-keep class com.google.android.material.** {*;}
-keep class androidx.** {*;}
-keep public class * extends androidx.**
-keep interface androidx.** {*;}
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**
-dontwarn androidx.**
-dontwarn android.support.v4.**
-keep class android.support.v4.** { *; }
-keep interface android.support.v4.** { *; }
-keep public class * extends android.support.v4.**
-keep class sun.misc.Unsafe { *; }
-keep class com.sigmob.**.**{*;}
-keep interface com.sigmob.**.**{*;}
-keep class com.czhj.**{*;}
-keep interface com.czhj.**{*;}

-dontwarn com.mediamain.android.**
-keep class com.mediamain.android.**{ *;}
-keepattributes Signature,SourceFile,LineNumberTable
-keepattributes *Annotation*
-keeppackagenames
-ignorewarnings
-dontwarn android.support.v4.**,**CompatHoneycomb,com.tenpay.android.**
-optimizations !class/unboxing/enum,!code/simplification/arithmetic
-dontwarn com.google.gson.**
-keep class com.google.gson.**{*;}
-keepattributes *Annotation*

-dontwarn com.beizi.fusion.**
-dontwarn com.beizi.ad.**
-keep class com.beizi.fusion.** {*; }
-keep class com.beizi.ad.** {*; }
-keep class com.qq.e.** {
    public protected *;
}
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,*Annotation*,EnclosingMethod
-dontwarn  org.apache.**
-dontwarn com.baidu.mobads.sdk.api.**
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keep class com.baidu.mobads.** { *; }
-keep class com.style.widget.** {*;}
-keep class com.component.** {*;}
-keep class com.baidu.ad.magic.flute.** {*;}
