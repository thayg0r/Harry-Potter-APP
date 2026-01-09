class ApiEndpoints {
  static const characters = '/characters';
  static const spells = '/spells';
  static String charactersByHouse(String house) => '/characters/house/$house';
}
