import 'package:flutter/material.dart';
import 'complaint.dart';

class ComplaintFormPage extends StatefulWidget {
  @override
  _ComplaintFormPageState createState() => _ComplaintFormPageState();
}

class _ComplaintFormPageState extends State<ComplaintFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _complaintController = TextEditingController();

  String? _selectedShop;
  String? _selectedComplaint;

  final List<String> _shops = ['Shop One', 'Shop Two', 'Shop Three'];
  final List<String> _commonComplaints = [
    'Incorrect billing amount',
    'Service not available',
    'Product not working',
    'Delivery delay'
  ];
  final List<String> _recommendations = [
    'Check your billing details.',
    'Ensure your service is active.',
    'Restart your device to fix technical issues.',
    'Inspect the product for defects before lodging a complaint.',
  ];

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  void _submitComplaint() {
    if (_formKey.currentState!.validate()) {
      final complaint = Complaint(
        shopName: _selectedShop!,
        complaintText: _complaintController.text,
        dateTime: DateTime.now(),
      );

      // Handle the complaint submission, e.g., save to a database or send to a server.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Complaint submitted')),
      );

      // Clear the form
      _complaintController.clear();
      setState(() {
        _selectedShop = null;
        _selectedComplaint = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Complaint'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select Shop'),
                value: _selectedShop,
                items: _shops.map((shop) {
                  return DropdownMenuItem(
                    value: shop,
                    child: Text(shop),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedShop = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a shop' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Select Common Complaint'),
                value: _selectedComplaint,
                items: _commonComplaints.map((complaint) {
                  return DropdownMenuItem(
                    value: complaint,
                    child: Text(complaint),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedComplaint = value;
                  });
                },
                validator: (value) => value == null ? 'Please select a common complaint' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _complaintController,
                decoration: InputDecoration(labelText: 'Complaint Details'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your complaint';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitComplaint,
                child: Text('Submit'),
              ),
              SizedBox(height: 20),
              Text(
                'Recommendations:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: _recommendations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.info, color: Colors.blue),
                      title: Text(_recommendations[index]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
