import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';


class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);

  final MultiSelectController _controller = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('WRAP'),
                const SizedBox(
                  height: 4,
                ),
                MultiSelectDropDown(
                  controller: _controller,
                  onOptionSelected: (List<ValueItem> selectedOptions) {},
                  options: const <ValueItem>[
                    ValueItem(label: 'Option 1', value: '1'),
                    ValueItem(label: 'Option 2', value: '2'),
                    ValueItem(label: 'Option 3', value: '3'),
                    ValueItem(label: 'Option 4', value: '4'),
                    ValueItem(label: 'Option 5', value: '5'),
                    ValueItem(label: 'Option 6', value: '6'),
                  ],
                  selectionType: SelectionType.multi,
                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  dropdownHeight: 300,
                  optionTextStyle: const TextStyle(fontSize: 16),
                  selectedOptionIcon: const Icon(Icons.check_circle),
                ),
                const SizedBox(
                  height: 50,
                ),
                Wrap(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _controller.clearAllSelection();
                      },
                      child: const Text('CLEAR'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {

                      },
                      child: const Text('Get Selected Options'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_controller.isDropdownOpen) {
                          _controller.hideDropdown();
                        } else {
                          _controller.showDropdown();
                        }
                      },
                      child: const Text('SHOW/HIDE DROPDOWN'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('SCROLL'),
                const SizedBox(
                  height: 4,
                ),
                MultiSelectDropDown(
                  onOptionSelected: (List<ValueItem> selectedOptions) {},
                  options: const <ValueItem>[
                    ValueItem(label: 'Option 1', value: '1'),
                    ValueItem(label: 'Option 2', value: '2'),
                    ValueItem(label: 'Option 3', value: '3'),
                    ValueItem(label: 'Option 4', value: '4'),
                    ValueItem(label: 'Option 5', value: '5'),
                    ValueItem(label: 'Option 6', value: '6'),
                  ],
                  selectionType: SelectionType.multi,
                  chipConfig: const ChipConfig(wrapType: WrapType.scroll),
                  dropdownHeight: 300,
                  optionTextStyle: const TextStyle(fontSize: 16),
                  selectedOptionIcon: const Icon(Icons.check_circle),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text('FROM NETWORK'),
                const SizedBox(
                  height: 4,
                ),
                MultiSelectDropDown.network(
                  onOptionSelected: (options) {},
                  networkConfig: NetworkConfig(
                    url: 'https://jsonplaceholder.typicode.com/users',
                    method: RequestMethod.get,
                    headers: {
                      'Content-Type': 'application/json',
                    },
                  ),
                  chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                  responseParser: (response) {
                    final list = (response as List<dynamic>).map((e) {
                      final item = e as Map<String, dynamic>;
                      return ValueItem(
                        label: item['name'],
                        value: item['id'].toString(),
                      );
                    }).toList();

                    return Future.value(list);
                  },
                  responseErrorBuilder: ((context, body) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Error fetching the data'),
                    );
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}