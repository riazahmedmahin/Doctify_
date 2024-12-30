import 'package:flutter/material.dart';

class TextFieldWithSortIcon extends StatefulWidget {
  @override
  _TextFieldWithSortIconState createState() => _TextFieldWithSortIconState();
}

class _TextFieldWithSortIconState extends State<TextFieldWithSortIcon> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _suggestions = []; // List to hold suggestions with names and designations
  final List<Map<String, String>> _doctors = [
    {'name': 'Dr. John Doe', 'designation': 'Cardiologist'},
    {'name': 'Dr. Jane Smith', 'designation': 'Dentist'},
    {'name': 'Dr. Emily Johnson', 'designation': 'Orthopedic Surgeon'},
    {'name': 'Dr. Michael Brown', 'designation': 'Dermatologist'},
    {'name': 'Dr. Linda Davis', 'designation': 'Pediatrician'},
  ]; // Sample doctors with designations

  List<String> _previousSearches = []; // List to store previous search terms
  bool _showPreviousSearches = false; // Flag to control when to show previous searches

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the controller to avoid memory leaks
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Update the suggestions based on the query
    if (query.isNotEmpty) {
      setState(() {
        _suggestions = _doctors
            .where((doctor) =>
                doctor['name']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  void _onSuggestionTap(String doctorName) {
    // Populate the text field with only the doctor's name
    _controller.text = doctorName;
    setState(() {
      _suggestions = []; // Clear suggestions after selection

      // Add doctorName to previous searches if it's not already present
      if (!_previousSearches.contains(doctorName)) {
        _previousSearches.add(doctorName);
      }

      _showPreviousSearches = false; // Hide previous searches after selection
    });
  }

  void _onSortButtonPressed() {
    setState(() {
      _showPreviousSearches = !_showPreviousSearches; // Toggle previous searches visibility
    });
  }

  void _onCancelPressed() {
    setState(() {
      _showPreviousSearches = false; // Hide previous searches
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 50,
                child: TextFormField(
                  controller: _controller,
                  onChanged: _onSearchChanged, // Call function on text change
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            GestureDetector(
              onTap: _onSortButtonPressed, // Handle sort button press
              child: Container(
                height: 50,
                width: 50, // Adjust size as needed
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 127, 125, 195),
                  borderRadius: BorderRadius.circular(5), // Adjust this value to control the roundness
                ),
                child: Center(
                  child: Icon(
                    Icons.sort_sharp, // Replace with your desired icon
                    color: Colors.white, // Icon color
                    size: 24, // Icon size
                  ),
                ),
              ),
            ),
          ],
        ),
        // Suggestions ListView
        if (_suggestions.isNotEmpty)
          Container(
            height: 200, // Adjust height as needed
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_suggestions[index]['name']!),
                  subtitle: Text(_suggestions[index]['designation']!), // Display designation below the name
                  onTap: () => _onSuggestionTap(_suggestions[index]['name']!), // Populate text field with doctor's name
                );
              },
            ),
          ),

        // Previous searches ListView with cancel button
        if (_showPreviousSearches && _previousSearches.isNotEmpty)
          Column(
            children: [
              Container(
                height: 90, // Adjust height as needed
                child: ListView.builder(
                  itemCount: _previousSearches.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_previousSearches[index]), // Display previous search doctor name
                      onTap: () => _onSuggestionTap(_previousSearches[index]), // Populate text field with previous search name
                    );
                  },
                ),
              ),
              // Cancel Button
              Align(
                alignment: Alignment.topRight, // Align it to the right
                child: Padding(
                  padding: const EdgeInsets.only(right: 6.0, bottom: 8.0),
                  child: IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red), // Cancel icon
                    onPressed: _onCancelPressed, // Close the previous searches list
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
