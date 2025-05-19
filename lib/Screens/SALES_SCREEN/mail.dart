import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:heat_portal/Services/email_service.dart';
import 'compose_mail.dart';
import 'mail2.dart';

class EmailPage extends StatefulWidget {
  const EmailPage({Key? key}) : super(key: key);

  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final EmailService ctrl = Get.put(EmailService());
  final search = ''.obs;

  @override
  void initState() {
    super.initState();
    _initEmail();
  }

  Future<void> _initEmail() async {
    // Ensure single sign-in prompt
    await ctrl.ensureClient();
    await ctrl.loadLabels();
    await ctrl.loadEmails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            Expanded(child: Obx(_buildList)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () => Get.to(() => ComposeEmailScreen()),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.indigo.shade600,
          Colors.indigo.shade400,
        ]),
      ),
      child: Row(
        children: [
          const Icon(Icons.email, color: Colors.white, size: 32),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('My Inbox',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600)),
              Text('Latest emails at a glance',
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _initEmail,
            tooltip: 'Refresh',
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search emails…',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (v) => search.value = v.toLowerCase(),
      ),
    );
  }

  Widget _buildList() {
    final isLoading = ctrl.isLoading.value;
    final err = ctrl.error.value;
    List<Map<String, dynamic>> list = ctrl.emails;
    if (search.value.isNotEmpty) {
      list = list.where((e) {
        final subj = (e['subject'] ?? '').toLowerCase();
        final from = (e['from'] ?? '').toLowerCase();
        return subj.contains(search.value) || from.contains(search.value);
      }).toList();
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (err != null) {
      return Center(child: Text(err, style: const TextStyle(color: Colors.red)));
    }
    if (list.isEmpty) {
      return Center(child: Text('No emails found.', style: TextStyle(color: Colors.grey.shade600)));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: list.length,
      itemBuilder: (_, i) {
        final e = list[i];
        final starred = e['starred'] == true;
        return Slidable(
          key: ValueKey(e['id']),
          endActionPane: ActionPane(
            motion: const DrawerMotion(),
            children: [
              SlidableAction(
                onPressed: (_) async => await ctrl.deleteEmail(e['id']),
                backgroundColor: Colors.red.shade400,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: (_) async {
                  if (starred) {
                    await ctrl.unstarEmail(e['id']);
                  } else {
                    await ctrl.starEmail(e['id']);
                  }
                },
                backgroundColor: Colors.yellow.shade700,
                foregroundColor: Colors.white,
                icon: starred ? Icons.star : Icons.star_border,
                label: starred ? 'Unstar' : 'Star',
              ),
              SlidableAction(
                onPressed: (_) => _showMoveSheet(context, e['id']),
                backgroundColor: Colors.blue.shade400,
                foregroundColor: Colors.white,
                icon: Icons.folder_open,
                label: 'Move',
              ),
            ],
          ),
          child: Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: Text((e['from'] ?? ' ')[0].toUpperCase(), style: const TextStyle(color: Colors.white)),
              ),
              title: Text(e['subject'] ?? '(No Subject)', style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(e['from'] ?? '(Unknown)', maxLines: 1, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Get.to(() => EmailDetailPage(email: Email(senderName: e['from'], senderEmail: e['from'], subject: e['subject'], date: DateTime.now()))),
            ),
          ),
        );
      },
    );
  }

  void _showMoveSheet(BuildContext ctx, String id) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => Obx(() {
        final labels = ctrl.labels.where((lab) => lab['name'] != null && lab['id'] != null).toList();
        if (labels.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView(
          children: labels.map((lab) {
            final name = lab['name'] ?? 'Unknown';
            final labId = lab['id'] ?? '';
            return ListTile(
              title: Text(name),
              onTap: () async {
                if (labId.isNotEmpty) {
                  await ctrl.moveEmail(id, labId);
                }
                Navigator.pop(ctx);
              },
            );
          }).toList(),
        );
      }),
    );
  }
}
