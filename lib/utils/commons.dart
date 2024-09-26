List<String> userInterestListData = [
  "Industry & Manufacturing",
  "Education & Career",
  "Sports & Motivation",
  "Laws & Constitution",
  "Women Empowerment",
  "Finance & Fintech",
  "Agriculture & Agritech",
  "Make In India",
  "NGO & Social Service",
  "It & Software",
  "E- Commerce",
  "Current Affairs",
];
String capitalize(String input) {
  List<String> words = input.split(' ');
  for (int i = 0; i < words.length; i++) {
    if (words[i].isNotEmpty) {
      words[i] = words[i][0].toUpperCase() + words[i].substring(1);
    }
  }
  return words.join(' ');
}

bool isIndividual(String value) {
  return value == "Individual";
}
