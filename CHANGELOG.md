CHANGELOG
=========

1.2.0
 - Added some new OpenRTB params

0.8.5
 - Moved SAUtils.h imports from SALoader.h to SALoader.m to fix issues when adding the Objective-C code alongside Swift code via CocoaPods with use_frameworks! enabled.

0.8.4
 - Fixed a bug in SAAdLoader that caused empty or invalid ads to actually revert to being gamewall type ads, instead of maintaining the invalid type
