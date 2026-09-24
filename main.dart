import 'package:flutter/material.dart';

void main() {
  runApp(const CamillianConnectApp());
}

class CamillianConnectApp extends StatelessWidget {
  const CamillianConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camillian Connect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      home: const LoginPage(),
    );
  }
}

// ============================================================
// LOGIN PAGE
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController codeController = TextEditingController();

  // Change this invitation code to whatever you want.
  static const String invitationCode = 'CAMILLIAN2026';

  void login() {
    if (codeController.text.trim() == invitationCode) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid invitation code'),
        ),
      );
    }
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.shade50,
                  ),
                  child: Icon(
                    Icons.favorite,
                    size: 60,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Camillian Connect',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Private Camillian Community Network',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: codeController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Invitation Code',
                    hintText: 'Enter your Camillian code',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: login,
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Access'),
                        content: const Text(
                          'This application is intended for approved members of the Camillian community.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text('Need access?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    FeedPage(),
    MembersPage(),
    NotificationsPage(),
    ProfilePage(),
  ];

  void openCreatePost() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const CreatePostSheet(),
    );
  }

  void openLanguages() {
    showModalBottomSheet(
      context: context,
      builder: (_) => const LanguageSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Camillian Connect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: openLanguages,
            icon: const Icon(Icons.language),
            tooltip: 'Language',
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
        ],
      ),
      body: pages[selectedIndex],
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              onPressed: openCreatePost,
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Members',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// FEED
// ============================================================

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        SectionBanner(
          title: 'Camillian Community',
          subtitle: 'Communion • Participation • Mission',
        ),
        SizedBox(height: 12),
        PostCard(
          name: 'Camillian Community',
          place: 'Rome',
          text:
              'Welcome to Camillian Connect. Let us remain united in prayer, service and care for the sick and suffering.',
          icon: Icons.favorite,
        ),
        PostCard(
          name: 'Camillian Ministry',
          place: 'Community',
          text:
              'Serving the sick with compassion, love and hope. May St. Camillus guide our ministry.',
          icon: Icons.local_hospital,
        ),
        PostCard(
          name: 'Community Prayer',
          place: 'Today',
          text:
              'Let us pray for all those who are sick, suffering and caring for the sick.',
          icon: Icons.church,
        ),
      ],
    );
  }
}

// ============================================================
// POST CARD
// ============================================================

class PostCard extends StatefulWidget {
  final String name;
  final String place;
  final String text;
  final IconData icon;

  const PostCard({
    super.key,
    required this.name,
    required this.place,
    required this.text,
    required this.icon,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool liked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.red.shade100,
                  child: Icon(
                    widget.icon,
                    color: Colors.red.shade700,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.place,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.text,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 12),
            const Divider(),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      liked = !liked;
                    });
                  },
                  icon: Icon(
                    liked ? Icons.favorite : Icons.favorite_border,
                    color: liked ? Colors.red : null,
                  ),
                ),
                const Text('Like'),
                const SizedBox(width: 20),
                const Icon(Icons.comment_outlined),
                const SizedBox(width: 6),
                const Text('Comment'),
                const Spacer(),
                const Icon(Icons.share_outlined),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// MEMBERS
// ============================================================

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final members = [
      {
        'name': 'Camillian Member',
        'place': 'Rome',
        'community': 'Camillian Community',
      },
      {
        'name': 'Community Member',
        'place': 'India',
        'community': 'Indian Province',
      },
      {
        'name': 'Camillian Brother',
        'place': 'Philippines',
        'community': 'Camillian Delegation',
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Camillian Members',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...members.map(
          (member) => Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(member['name']![0]),
              ),
              title: Text(
                member['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${member['place']} • ${member['community']}',
              ),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// NOTIFICATIONS
// ============================================================

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            'Notifications',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Welcome to Camillian Connect'),
            subtitle: Text('Your community network is ready.'),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Community Prayer'),
            subtitle: Text('Remember the sick and suffering in prayer.'),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 20),
        const Center(
          child: CircleAvatar(
            radius: 55,
            child: Icon(
              Icons.person,
              size: 60,
            ),
          ),
        ),
        const SizedBox(height: 18),
        const Center(
          child: Text(
            'Camillian Member',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Center(
          child: Text('Camillian Community'),
        ),
        const SizedBox(height: 24),
        const ProfileInfo(
          icon: Icons.location_on,
          title: 'Place',
          value: 'Not specified',
        ),
        const ProfileInfo(
          icon: Icons.account_balance,
          title: 'Province / Delegation / Community',
          value: 'Not specified',
        ),
        const ProfileInfo(
          icon: Icons.work,
          title: 'Ministry / Role',
          value: 'Not specified',
        ),
        const ProfileInfo(
          icon: Icons.info_outline,
          title: 'Biography',
          value: 'Add your biography here.',
        ),
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile editing will be available soon.'),
              ),
            );
          },
          icon: const Icon(Icons.edit),
          label: const Text('Edit Profile'),
        ),
      ],
    );
  }
}

class ProfileInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(value),
      ),
    );
  }
}

// ============================================================
// CREATE POST
// ============================================================

class CreatePostSheet extends StatefulWidget {
  const CreatePostSheet({super.key});

  @override
  State<CreatePostSheet> createState() => _CreatePostSheetState();
}

class _CreatePostSheetState extends State<CreatePostSheet> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Create Post',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Write something for the community...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Post created successfully.',
                      ),
                    ),
                  );
                },
                child: const Text('Publish'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// LANGUAGE SHEET
// ============================================================

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = [
      'English',
      'Tamil',
      'Malayalam',
      'Hindi',
      'Telugu',
      'Kannada',
      'Spanish',
      'Italian',
      'French',
      'Portuguese',
      'German',
    ];

    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Choose Language',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...languages.map(
            (language) => ListTile(
              leading: const Icon(Icons.language),
              title: Text(language),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$language selected'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// SECTION BANNER
// ============================================================

class SectionBanner extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionBanner({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.red.shade700,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.white,
            size: 35,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
