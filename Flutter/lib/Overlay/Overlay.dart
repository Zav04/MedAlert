import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../Controller/ChangePageOverlay.dart';

mixin ErrorMessageOverlayMixin<T extends StatefulWidget> on State<T> {
  OverlayEntry? overlayEntry;
  VoidCallback? onButtonPressed;

  void showErrorMessageOverlay(String message, int typeofOverlay,
      {ErrorMessageAction? action}) {
    overlayEntry?.remove();
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: <Widget>[
          Positioned.fill(
            child: GestureDetector(
              onTap: () => removeErrorMessageOverlay(),
              child: Container(
                color: Colors.black54,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Material(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: typeofOverlay == 1
                      ? Colors.redAccent
                      : typeofOverlay == 2
                          ? Colors.greenAccent
                          : Colors.grey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                          typeofOverlay == 1
                              ? Icons.error_outline
                              : typeofOverlay == 2
                                  ? Icons.check_circle_outline
                                  : Icons.error_outline,
                          color: Colors.white,
                          size: 40),
                      const SizedBox(width: 8),
                      const Gap(10),
                      Text(
                        message,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                      const Gap(2),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          removeErrorMessageOverlay();
                          action?.execute(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: typeofOverlay == 1
                              ? Colors.redAccent
                              : typeofOverlay == 2
                                  ? Colors.greenAccent
                                  : Colors.grey,
                        ),
                        child: const Text('OK', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // Insere o overlay
    Overlay.of(context).insert(overlayEntry!);
  }

  void removeErrorMessageOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
