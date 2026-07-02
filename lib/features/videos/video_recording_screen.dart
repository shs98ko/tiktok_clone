import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';
import 'package:tiktok_clone/features/videos/widgets/video_flash_button.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

/* 카메라
1. 직접 만든 인터페이스와 버튼을 가진 카메라 만들기
2. 사용자가 자신의 라이브러리에서 가져온 비디오중에서 선택
3. 사용자의 폰에 있는 카메라 어플로 리다릭트해주기 */
class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  bool _hasPermissions = false;
  bool _selfieMode = false;

  late FlashMode _flashMode;

  late CameraController _cameraController;

  late final AnimationController _buttonAnimationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 200));

  late final Animation<double> _buttonAnimation = Tween(
    begin: 1.0,
    end: 1.3,
  ).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
        vsync: this,
        duration: const Duration(seconds: 10),
        lowerBound: 0.0,
        upperBound: 1.0,
      );

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.forward();
    _progressAnimationController.forward();

    await _cameraController.startVideoRecording();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    final video = await _cameraController.stopVideoRecording();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VideoPreviewScreen(video: video)),
    );
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermissions = true;
      await initCamera();
      setState(() {});
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }
    _cameraController = CameraController(
      cameras[_selfieMode ? 0 : 1],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();
    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> _toggleSelfiMode() async {
    _selfieMode = !_selfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _buttonAnimationController.dispose();
    _progressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermissions || !_cameraController.value.isInitialized
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Initializing ...",
                      style: TextStyle(color: Colors.white),
                    ),
                    Gaps.v20,
                    CircularProgressIndicator.adaptive(),
                  ],
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: CameraPreview(_cameraController),
                  ),
                  Positioned(
                    top: Sizes.size36,
                    right: Sizes.size20,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: _toggleSelfiMode,
                          icon: Icon(
                            Icons.cameraswitch_outlined,
                            size: Sizes.size36,
                            color: Colors.white,
                          ),
                        ),
                        Gaps.v10,
                        VideoFlashButton(
                          icon: Icons.flash_off_rounded,
                          setFlashMode: _setFlashMode,
                          currentFlashMode: _flashMode,
                          newFlashMode: FlashMode.off,
                        ),
                        Gaps.v10,
                        VideoFlashButton(
                          icon: Icons.flash_on_rounded,
                          setFlashMode: _setFlashMode,
                          currentFlashMode: _flashMode,
                          newFlashMode: FlashMode.always,
                        ),
                        Gaps.v10,
                        VideoFlashButton(
                          icon: Icons.flash_auto_rounded,
                          setFlashMode: _setFlashMode,
                          currentFlashMode: _flashMode,
                          newFlashMode: FlashMode.auto,
                        ),
                        Gaps.v10,
                        VideoFlashButton(
                          icon: Icons.flashlight_on_rounded,
                          setFlashMode: _setFlashMode,
                          currentFlashMode: _flashMode,
                          newFlashMode: FlashMode.torch,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: Sizes.size48,
                    child: GestureDetector(
                      onTapDown: _startRecording,
                      onTapUp: (detail) => _stopRecording(),
                      child: ScaleTransition(
                        scale: _buttonAnimation,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: Sizes.size64,
                              height: Sizes.size64,
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.red,
                                strokeWidth: Sizes.size6,
                                value: _progressAnimationController.value,
                              ),
                            ),
                            Container(
                              width: Sizes.size60,
                              height: Sizes.size60,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
