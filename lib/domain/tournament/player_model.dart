class PlayerModel {
  final String image;
  final String name;
  final int id;
  final bool isSelected;

  PlayerModel({
    required this.image,
    required this.name,
    required this.id,
    required this.isSelected,
  });
}

List<PlayerModel> playerModel = [
  PlayerModel(
    image: 'assets/images/goal.png',
    name: 'Tanvir Ahmed',
    id: 0,
    isSelected: false,
  ),
  PlayerModel(
    image: 'assets/images/goal.png',
    name: 'Tanvir Ahmed',
    id: 1,
    isSelected: false,
  ),
  PlayerModel(
    image: 'assets/images/goal.png',
    name: 'Tanvir Ahmed',
    id: 2,
    isSelected: false,
  ),
  PlayerModel(
    image: 'assets/images/goal.png',
    name: 'Tanvir Ahmed 1',
    id: 3,
    isSelected: false,
  ),
  PlayerModel(
    image: 'assets/images/goal.png',
    name: 'Tanvir Ahmed 2',
    id: 4,
    isSelected: false,
  ),
  PlayerModel(
    image: 'assets/images/goal.png',
    name: 'Tanvir Ahmed 3',
    id: 5,
    isSelected: false,
  ),
  PlayerModel(
    image: 'assets/images/goal.png',
    name: 'Tanvir Ahmed 4',
    id: 6,
    isSelected: false,
  ),
  PlayerModel(
    image: 'assets/images/goal.png',
    name: 'Tanvir Ahmed 5',
    id: 7,
    isSelected: false,
  ),
  PlayerModel(
    image: 'assets/images/goal.png',
    name: 'Tanvir Ahmed 6',
    id: 8,
    isSelected: false,
  ),
];

class StaticVariable {
  static const List<String> PlayerNamelist = [
    'Tavnir Ahmed',
    'Tavnir Ahmed 1',
    'Tavnir Ahmed 2',
    'Tavnir Ahmed 3',
    'Tavnir Ahmed 5',
    'Tavnir Ahmed 6',
    'Tavnir Ahmed 7',
  ];
}
