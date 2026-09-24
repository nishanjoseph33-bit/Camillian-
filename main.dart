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
        fontFamily: 'sans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B1E1E),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F2EC),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final codeController = TextEditingController();
  bool obscure = true;
  bool loading = false;

  void login() async {
    setState(() => loading = true);
    await Future.delayed(const Duration(milliseconds: 650));
    if (!mounted) return;
    setState(() => loading = false);

    // Demo access code. Production version should validate invitations
    // on a secure backend/Firebase, never inside the APK.
    if (codeController.text.trim().toUpperCase() == 'CAMILLUS2026') {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const ShellPage(),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Access code not recognized. Please contact your administrator.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/camillian_hero.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.08),
                    Colors.black.withOpacity(.62),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Column(
                    children: [
                      const Icon(Icons.add_circle_outline_rounded,
                          size: 64, color: Colors.white),
                      const SizedBox(height: 12),
                      const Text(
                        'CAMILLIAN CONNECT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Communion • Service • Mission',
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                      const SizedBox(height: 30),
                      Card(
                        elevation: 14,
                        shadowColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Member Login',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Private access for approved Camillian members.',
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  height: 1.35,
                                ),
                              ),
                              const SizedBox(height: 22),
                              TextField(
                                controller: codeController,
                                obscureText: obscure,
                                textCapitalization: TextCapitalization.characters,
                                decoration: InputDecoration(
                                  labelText: 'Invitation / access code',
                                  prefixIcon: const Icon(Icons.vpn_key_rounded),
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(() => obscure = !obscure),
                                    icon: Icon(obscure
                                        ? Icons.visibility_rounded
                                        : Icons.visibility_off_rounded),
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF5F2EF),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: FilledButton.icon(
                                  onPressed: loading ? null : login,
                                  icon: loading
                                      ? const SizedBox(
                                          width: 19,
                                          height: 19,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Icon(Icons.login_rounded),
                                  label: Text(loading ? 'Checking…' : 'Enter Camillian Connect'),
                                  style: FilledButton.styleFrom(
                                    backgroundColor: const Color(0xFF8B1E1E),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Center(
                                child: TextButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) => const AlertDialog(
                                      title: Text('Account recovery'),
                                      content: Text(
                                        'In the production app, recovery will be handled by the approved member account and administrator-controlled email/phone verification.',
                                      ),
                                    ),
                                  ),
                                  child: const Text('Forgot password / need help?'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Demo access code: CAMILLUS2026',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
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
  }
}

class ShellPage extends StatefulWidget {
  const ShellPage({super.key});
  @override
  State<ShellPage> createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  int index = 0;
  final pages = const [
    HomePage(),
    NewsPage(),
    CommunitiesPage(),
    EventsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 260),
        child: KeyedSubtree(key: ValueKey(index), child: pages[index]),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.newspaper_outlined), selectedIcon: Icon(Icons.newspaper), label: 'News'),
          NavigationDestination(icon: Icon(Icons.groups_outlined), selectedIcon: Icon(Icons.groups), label: 'Communities'),
          NavigationDestination(icon: Icon(Icons.event_outlined), selectedIcon: Icon(Icons.event), label: 'Events'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      floatingActionButton: index == 0
          ? FloatingActionButton.extended(
              backgroundColor: const Color(0xFF8B1E1E),
              foregroundColor: Colors.white,
              onPressed: () => showModalBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (_) => const CreatePostSheet(),
              ),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Post'),
            )
          : null,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 190,
          backgroundColor: const Color(0xFF8B1E1E),
          foregroundColor: Colors.white,
          title: const Text('Camillian Connect',
              style: TextStyle(fontWeight: FontWeight.w800)),
          actions: [
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) => const AlertDialog(
                  title: Text('Messages'),
                  content: Text('Private messages and community chats will appear here.'),
                ),
              ),
              icon: const Icon(Icons.chat_bubble_outline_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/camillian_hero.png', fit: BoxFit.cover),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withOpacity(.55)],
                    ),
                  ),
                ),
                const Positioned(
                  left: 20,
                  bottom: 18,
                  child: Text(
                    '“Care for the sick as if caring for Christ.”',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(14, 14, 14, 90),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const StoryStrip(),
              const SizedBox(height: 14),
              const PostCard(
                author: 'General Curia',
                place: 'Rome • Camillian Family',
                time: 'Today',
                text:
                    'Welcome to Camillian Connect — a private digital home for communion, formation, mission and service to the sick.',
                tags: ['#CamillianFamily', '#MinistersOfTheSick'],
              ),
              const PostCard(
                author: 'Formation Community',
                place: 'Community News',
                time: 'Yesterday',
                text:
                    'A week of prayer and reflection begins with the theme: “Mercy that becomes service.” Members are invited to share reflections.',
                tags: ['#Formation', '#Prayer'],
              ),
              const PostCard(
                author: 'Mission Network',
                place: 'Mission Activity',
                time: '2 days ago',
                text:
                    'Sharing stories of compassionate presence with patients, families and healthcare workers around the world.',
                tags: ['#Mission', '#Compassion'],
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class StoryStrip extends StatelessWidget {
  const StoryStrip({super.key});
  @override
  Widget build(BuildContext context) {
    final items = ['Curia', 'India', 'Italy', 'Formation', 'Mission'];
    return SizedBox(
      height: 90,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (_, i) => Column(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B1E1E), Color(0xFFD27C35)],
                ),
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: const [BoxShadow(blurRadius: 8, color: Colors.black12)],
              ),
              child: const Icon(Icons.add_circle_outline, color: Colors.white),
            ),
            const SizedBox(height: 5),
            Text(items[i], style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatefulWidget {
  final String author, place, time, text;
  final List<String> tags;
  const PostCard({
    super.key,
    required this.author,
    required this.place,
    required this.time,
    required this.text,
    required this.tags,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool liked = false;
  int likes = 24;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF8B1E1E),
                  child: Icon(Icons.local_hospital_outlined, color: Colors.white),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.author, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('${widget.place} • ${widget.time}',
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz),
              ],
            ),
            const SizedBox(height: 14),
            Text(widget.text, style: const TextStyle(fontSize: 15, height: 1.45)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 7,
              children: widget.tags
                  .map((t) => Text(t,
                      style: const TextStyle(
                        color: Color(0xFF8B1E1E),
                        fontWeight: FontWeight.w600,
                      )))
                  .toList(),
            ),
            const Divider(height: 24),
            Row(
              children: [
                IconButton(
                  onPressed: () => setState(() {
                    liked = !liked;
                    likes += liked ? 1 : -1;
                  }),
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    child: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey(liked),
                      color: liked ? const Color(0xFFB3261E) : null,
                    ),
                  ),
                ),
                Text('$likes'),
                const SizedBox(width: 14),
                IconButton(onPressed: () {}, icon: const Icon(Icons.mode_comment_outlined)),
                const Text('8'),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final news = [
      ('General Curia', 'General Curia news and announcements', Icons.account_balance),
      ('Provinces & Delegations', 'Updates from provinces and delegations', Icons.public),
      ('Formation', 'Formation programmes and community life', Icons.school),
      ('Mission', 'Mission activities and service to the sick', Icons.volunteer_activism),
      ('Celebrations', 'Feast days, jubilees and community celebrations', Icons.celebration),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camillian News', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionBanner(
            title: 'Newsroom',
            subtitle: 'One family, many places, one mission.',
          ),
          const SizedBox(height: 14),
          ...news.map((n) => Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFF1DFD8),
                    child: Icon(n.$3, color: const Color(0xFF8B1E1E)),
                  ),
                  title: Text(n.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(n.$2),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              )),
        ],
      ),
    );
  }
}

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final groups = [
      ('Provinces', Icons.map_outlined, 'Browse province communities'),
      ('Delegations', Icons.account_tree_outlined, 'Connect across delegations'),
      ('Communities', Icons.home_work_outlined, 'Local community spaces'),
      ('Formation Houses', Icons.school_outlined, 'Formation and vocation'),
      ('Ministries', Icons.volunteer_activism_outlined, 'Healthcare and pastoral service'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communities', style: TextStyle(fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionBanner(
            title: 'Camillian Family',
            subtitle: 'Find your province, delegation, community or ministry.',
          ),
          const SizedBox(height: 14),
          ...groups.map((g) => Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  leading: Icon(g.$2, size: 30, color: const Color(0xFF8B1E1E)),
                  title: Text(g.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(g.$3),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
              )),
        ],
      ),
    );
  }
}

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});
  @override
  Widget build(BuildContext context) {
    final events = [
      ('28 Sep', 'Camillian Formation Webinar', 'Online • Formation'),
      ('04 Oct', 'Community Retreat', 'Bengaluru • Retreat'),
      ('14 Oct', 'Feast of St. Camillus Celebration', 'All communities • Celebration'),
      ('02 Nov', 'Healthcare Ministry Conference', 'Rome • Conference'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add_alert_outlined))],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionBanner(
            title: 'Gather • Pray • Serve',
            subtitle: 'Retreats, conferences, chapters, formation and celebrations.',
          ),
          const SizedBox(height: 14),
          ...events.map((e) => Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(14),
                  leading: Container(
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B1E1E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Text(e.$1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                  title: Text(e.$2, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(e.$3),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              )),
        ],
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (_) => const LanguageSheet(),
            ),
            icon: const Icon(Icons.translate_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 46,
                    backgroundColor: Color(0xFF8B1E1E),
                    child: Icon(Icons.person, color: Colors.white, size: 50),
                  ),
                  const SizedBox(height: 12),
                  const Text('Camillian Member',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                  Text('Place: Bengaluru',
                      style: TextStyle(color: Colors.grey.shade700)),
                  Text('Province / Delegation / Community',
                      style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(height: 12),
                  const Text(
                    'Servant of the sick • Community ministry • Formation',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          _profileTile(context, Icons.edit_outlined, 'Edit profile'),
          _profileTile(context, Icons.language_outlined, 'Language', onTap: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (_) => const LanguageSheet(),
            );
          }),
          _profileTile(context, Icons.admin_panel_settings_outlined, 'Admin dashboard',
              onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminPage()),
            );
          }),
          _profileTile(context, Icons.lock_outline, 'Privacy & security'),
          _profileTile(context, Icons.help_outline, 'Help & support'),
          _profileTile(context, Icons.logout_rounded, 'Sign out', danger: true),
        ],
      ),
    );
  }

  Widget _profileTile(BuildContext context, IconData icon, String title,
      {VoidCallback? onTap, bool danger = false}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: danger ? Colors.red : const Color(0xFF8B1E1E)),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  @override
  Widget build(BuildContext context) {
    final actions = [
      ('Approve members', Icons.person_add_alt_1, '4 pending'),
      ('Manage communities', Icons.account_tree, '12 provinces'),
      ('Moderate posts', Icons.shield_outlined, '2 flagged'),
      ('Publish announcement', Icons.campaign_outlined, 'Create'),
      ('Manage events', Icons.event_note_outlined, '7 upcoming'),
      ('Languages', Icons.translate, '13 enabled'),
      ('Suspend account', Icons.person_off_outlined, 'Controlled'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SectionBanner(
            title: 'Community Administration',
            subtitle: 'Member approval, moderation, news, events and languages.',
          ),
          const SizedBox(height: 14),
          ...actions.map((a) => Card(
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFF1DFD8),
                    child: Icon(a.$2, color: const Color(0xFF8B1E1E)),
                  ),
                  title: Text(a.$1, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(a.$3),
                  trailing: const Icon(Icons.chevron_right),
                ),
              )),
        ],
      ),
    );
  }
}

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final languages = [
      'English', 'Italian', 'Spanish', 'Portuguese', 'French', 'German',
      'Tamil', 'Malayalam', 'Hindi', 'Telugu', 'Kannada', 'Vietnamese', 'Filipino'
    ];
    return SafeArea(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(18),
        children: [
          const Text('Choose language',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('The production version will localize the complete interface and content.'),
          const SizedBox(height: 12),
          ...languages.map((l) => ListTile(
                leading: const Icon(Icons.translate),
                title: Text(l),
                trailing: l == 'English'
                    ? const Icon(Icons.check_circle, color: Color(0xFF8B1E1E))
                    : null,
                onTap: () => Navigator.pop(context),
              )),
        ],
      ),
    );
  }
}

class CreatePostSheet extends StatelessWidget {
  const CreatePostSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Create a post',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),
            _action(context, Icons.photo_library_outlined, 'Photo / video'),
            _action(context, Icons.edit_note_outlined, 'Text / reflection'),
            _action(context, Icons.menu_book_outlined, 'Scripture'),
            _action(context, Icons.event_outlined, 'Event'),
          ],
        ),
      ),
    );
  }

  Widget _action(BuildContext context, IconData icon, String title) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFF1DFD8),
        child: Icon(icon, color: const Color(0xFF8B1E1E)),
      ),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => Navigator.pop(context),
    );
  }
}

class SectionBanner extends StatelessWidget {
  final String title, subtitle;
  const SectionBanner({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/camillian_hero.png'),
          fit: BoxFit.cover,
          opacity: .38,
        ),
        color: const Color(0xFF8B1E1E),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(color: Colors.white, height: 1.35)),
        ],
      ),
    );
  }
}
