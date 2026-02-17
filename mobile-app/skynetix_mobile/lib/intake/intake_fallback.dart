class IntakeFallback {
  const IntakeFallback._(); // prevent instantiation

  static void toOffline(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => const OfflineEmergencyScreen(),
      ),
      (_) => false,
    );
  }
}
