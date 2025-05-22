import 'package:flutter/material.dart';

class FindDonorsScreen extends StatefulWidget {
  const FindDonorsScreen({super.key});

  @override
  State<FindDonorsScreen> createState() => _FindDonorsScreen();
}

class _FindDonorsScreen extends State<FindDonorsScreen> {
  String? selectedBloodGroup;
  String? selectedLocation;

  final List<Map<String, dynamic>> donors = [
    {
      'name': 'Jane Smith',
      'bloodGroup': 'B+',
      'location': 'Los Angeles',
      'availability': false,
      'lastDonated': '1 month ago',
      'contact': '987-654-3210',
    },
    {
      'name': 'Alice Johnson',
      'bloodGroup': '0-',
      'location': 'Chicago',
      'availability': true,
      'lastDonated': '3 days ago',
      'contact': '555-123-4567',
    },
    {
      'name': 'Bob Brown',
      'bloodGroup': 'AB+',
      'location': 'Houston',
      'availability': true,
      'lastDonated': '1 week ago',
      'contact': '444-555-6666',
    },
    {
      'name': 'Charlie Davis',
      'bloodGroup': 'A-',
      'location': 'Phoenix',
      'availability': false,
      'lastDonated': '2 month ago',
      'contact': '333-222-1111',
    },
    {
      'name': 'Eve White',
      'bloodGroup': 'B-',
      'location': 'New York',
      'availability': true,
      'lastDonated': '1 week ago',
      'contact': '222-333-4444',
    },
    {
      'name': 'David Green',
      'bloodGroup': '0+',
      'location': 'Los Angeles',
      'availability': true,
      'lastDonated': '5 days ago',
      'contact': '111-222-3333',
    },
    {
      'name': 'Grace Black',
      'bloodGroup': 'AB-',
      'location': 'Chicago',
      'availability': false,
      'lastDonated': '3 weeks ago',
      'contact': '666-777-8888',
    },
    {
      'name': 'Henry Wilson',
      'bloodGroup': 'A+',
      'location': 'Houston',
      'availability': true,
      'lastDonated': '2 weeks ago',
      'contact': '999-888-7777',
    },
    {
      'name': 'Isabella Martinez',
      'bloodGroup': 'B+',
      'location': 'Phoenix',
      'availability': true,
      'lastDonated': '1 month ago',
      'contact': '555-444-3333',
    },
  ];
  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    '0+',
    '0-',
  ];
  final List<String> locations = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
  ];

  @override
  Widget build(BuildContext context) {
    final filteredDonors =
        donors.where((donor) {
          final matchesBloodGroup =
              selectedBloodGroup == null ||
              donor['bloodGroup'] == selectedBloodGroup;
          final matchesLocation =
              selectedLocation == null || donor['location'] == selectedLocation;
          return matchesBloodGroup && matchesLocation;
        }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xFFE53935), Color(0xFFFF8A80)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Find Donors',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Search for blood donors in your area',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter by Blood Group',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            bloodTypes.map((bloodType) {
                              return Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: ChoiceChip(
                                  checkmarkColor:
                                      selectedBloodGroup == bloodType
                                          ? Colors.white
                                          : Colors.black,
                                  label: Text(bloodType),
                                  selected: selectedBloodGroup == bloodType,
                                  onSelected: (selected) {
                                    setState(() {
                                      selectedBloodGroup =
                                          selected ? bloodType : null;
                                    });
                                  },
                                  selectedColor: Color(0xFFE53935),
                                  labelStyle: TextStyle(
                                    color:
                                        selectedBloodGroup == bloodType
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedLocation,
                      decoration: InputDecoration(
                        labelText: 'Select Location',
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Color(0xFFE53935),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items:
                          locations.map((location) {
                            return DropdownMenuItem(
                              value: location,
                              child: Text(location),
                            );
                          }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    filteredDonors.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.search_off,
                                size: 100,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No donors found',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'Try adjusting your filters',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                        : ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredDonors.length,
                          itemBuilder: (context, index) {
                            final donor = filteredDonors[index];
                            return _buildDonorCard(donor);
                          },
                        ),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDonorCard(Map<String, dynamic> donor) {
    return Card(
      elevation: 4,
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  donor['name'],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color:
                        donor['availability'] ? Color(0xFFE53935) : Colors.grey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    donor['availability'] ? 'Available' : 'Not Available',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                _buildInfoChip(
                  icon: Icons.bloodtype,
                  text: donor['bloodGroup'],
                ),
                SizedBox(width: 8),
                _buildInfoChip(
                  icon: Icons.location_on,
                  text: donor['location'],
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Last Donated: ${donor['lastDonated']}',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed:
                        donor['availability']
                            ? () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text(
                                      'Contact Donor',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Contact Number: ${donor['contact']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          'Do you want to call this donor?',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Press Call to proceed.',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE53935),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Call',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                            : null,
                    child: Text('Contact Donor'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE53935),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Color(0xFFE53935),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
