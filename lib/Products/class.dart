class Product {
  final String brand;
  final String name;
  final String price;
  final String image;
  final String source;

  Product({
    required this.brand,
    required this.name,
    required this.price,
    required this.image,
    required this.source,
  });
}

final List<Map<String, String>> amazonCategory = [
  {
    'Appliances':
        'https://www.amazon.in/s?bbn=5122349031&rh=n%3A5122348031%2Cn%3A4951860031&dc&qid=1706030387&rnid=5122349031&ref=lp_5122349031_nr_n_1'
  },
  {
    'Beauty':
        'https://www.amazon.in/s?k=beauty+and+personal+care&i=beauty&crid=3GV8OUCQ5HDDW&sprefix=%2Cbeauty%2C176&ref=nb_sb_ss_recent_1_0_recent'
  },
  {
    'Boy\'s Clothing':
        'https://www.amazon.in/s?k=boys+clothing&i=apparel&crid=1QXHKQ0HT1X9R&sprefix=boys+cl%2Capparel%2C187&ref=nb_sb_ss_ts-doa-p_1_7'
  },
  {
    'Electronics':
        'https://www.amazon.in/s?k=electronics&i=electronics&crid=3UC8JI1RNI83D&sprefix=electroni%2Celectronics%2C200&ref=nb_sb_noss_2'
  },
  {
    'Furniture':
        'https://www.amazon.in/s?k=furniture&i=furniture&crid=36VRTVECC2VVZ&sprefix=furniture%2Cfurniture%2C189&ref=nb_sb_noss_1'
  },
  {
    'Girl\'s CLothing':
        'https://www.amazon.in/s?k=girls+clothing&i=apparel&crid=2QD3S1HUXBL0A&sprefix=girls%2Capparel%2C182&ref=nb_sb_ss_ts-doa-p_2_5'
  },
  {
    'Grocery':
        'https://www.amazon.in/s?k=grocery&i=grocery&crid=389RFA9AXLH3S&sprefix=grocery%2Cgrocery%2C188&ref=nb_sb_noss_1'
  },
  {
    'Health & Personal Care':
        'https://www.amazon.in/s?k=health+and+personal+care&i=hpc&crid=32SSXWS3FGFSP&sprefix=health+and+%2Chpc%2C189&ref=nb_sb_ss_ts-doa-p_1_11'
  },
  {
    'Home & Kitchen':
        'https://www.amazon.in/s?k=home+and+kitchen&i=kitchen&crid=29W8TBAZJGF4&sprefix=home+and+kitchen%2Ckitchen%2C184&ref=nb_sb_noss_1'
  },
  {
    'Men\'s Clothing':
        'https://www.amazon.in/s?k=mens+clothing&i=apparel&crid=3EKEB9B1OH4HL&sprefix=mens+cl%2Capparel%2C180&ref=nb_sb_ss_ts-doa-p_2_7'
  },
  {
    'Pet Supplies':
        'https://www.amazon.in/s?k=pet+supplies&i=pets&crid=1YLABT1OB5XYQ&sprefix=pet+supplies%2Cpets%2C178&ref=nb_sb_noss_1'
  },
  {
    'Sports':
        'https://www.amazon.in/s?k=sports&i=sporting&crid=1VHOWZES95USX&sprefix=sports%2Csporting%2C180&ref=nb_sb_noss_1'
  },
  {
    'Watches':
        'https://www.amazon.in/s?k=watches&i=watches&crid=3DUM7AQLGLD3Y&sprefix=watches%2Cwatches%2C189&ref=nb_sb_noss_1'
  },
  {
    'Women\'s Clothing':
        'https://www.amazon.in/s?k=women+clothing&i=apparel&crid=NV135L5ZIDGR&sprefix=women+clothing%2Capparel%2C173&ref=nb_sb_noss_1'
  },
];

final List<Map<String, String>> bigBasketCategory = [
  {
    'Appliances':
        'https://www.bigbasket.com/pc/kitchen-garden-pets/appliances-electricals/?nc=nb&page=2'
  },
  {
    'Beauty': 'https://www.bigbasket.com/ps/?q=beauty&nc=as',
  },
  {
    'Boy\'s Clothing': 'https://www.bigbasket.com/ps/?q=boys&nc=as',
  },
  {
    'Electronics': 'https://www.bigbasket.com/ps/?q=electricals&nc=as',
  },
  {
    'Furniture': 'https://www.bigbasket.com/ps/?q=furniture&nc=as',
  },
  {
    'Girl\'s CLothing': 'https://www.bigbasket.com/ps/?q=girls&nc=as',
  },
  {
    'Grocery': 'https://www.bigbasket.com/ps/?q=grocery&nc=as',
  },
  {
    'Health & Personal Care': 'https://www.bigbasket.com/ps/?q=health&nc=as',
  },
  {
    'Home & Kitchen': 'https://www.bigbasket.com/ps/?q=kitchen&nc=as',
  },
  {
    'Men\'s Clothing': 'https://www.bigbasket.com/ps/?q=men&nc=as',
  },
  {
    'Pet Supplies': 'https://www.bigbasket.com/ps/?q=pet&nc=as',
  },
  {
    'Sports': 'https://www.bigbasket.com/ps/?q=sports&nc=as',
  },
  {
    'Watches': 'https://www.bigbasket.com/ps/?q=watch&nc=as',
  },
  {
    'Women\'s Clothing': 'https://www.bigbasket.com/ps/?q=women&nc=as',
  },
];

final List<Map<String, String>> jiomartCategory = [
  {
    'Appliances': 'https://www.jiomart.com/c/electronics/home-appliances/724',
  },
  {
    'Beauty': 'https://www.jiomart.com/c/beauty/5',
  },
  {
    'Boy\'s Clothing': 'https://www.jiomart.com/c/fashion/boys/499',
  },
  {
    'Electronics': 'https://www.jiomart.com/c/electronics/4',
  },
  {
    'Furniture': 'https://www.jiomart.com/c/homeandkitchen/home-decor/8722',
  },
  {
    'Girl\'s CLothing': 'https://www.jiomart.com/c/fashion/girls/563',
  },
  {
    'Grocery': 'https://www.jiomart.com/c/groceries/2',
  },
  {
    'Health & Personal Care':
        'https://www.jiomart.com/c/groceries/personal-care/91',
  },
  {
    'Home & Kitchen': 'https://www.jiomart.com/c/homeandkitchen/8582',
  },
  {
    'Men\'s Clothing': 'https://www.jiomart.com/c/fashion/men/496',
  },
  {
    'Pet Supplies': 'https://www.jiomart.com/c/groceries/pets/3346',
  },
  {
    'Sports':
        'https://www.jiomart.com/c/sportstoysluggage/sporting-goods-fitness-equipment/9279',
  },
  {
    'Watches': 'https://www.jiomart.com/search/watches',
  },
  {
    'Women\'s Clothing': 'https://www.jiomart.com/c/fashion/women/493',
  },
];

final List<Map<String, String>> myntraCategory = [
  {
    'Appliances': 'https://www.myntra.com/appliances?rawQuery=Appliances',
  },
  {
    'Beauty': 'https://www.myntra.com/beauty?rawQuery=beauty',
  },
  {
    'Boy\'s Clothing':
        'https://www.myntra.com/boys-clothing?rawQuery=boys%20clothing',
  },
  {
    'Electronics': 'https://www.myntra.com/electronics?rawQuery=electronics',
  },
  {
    'Furniture': 'https://www.myntra.com/furniture?rawQuery=Furniture',
  },
  {
    'Girl\'s CLothing':
        'https://www.myntra.com/girls-clothing?rawQuery=girls%20clothing',
  },
  {
    'Grocery': 'https://www.myntra.com/grocery?rawQuery=grocery',
  },
  {
    'Health & Personal Care':
        'https://www.myntra.com/personal-care?rawQuery=personal%20care',
  },
  {
    'Home & Kitchen': 'https://www.myntra.com/kitchen?rawQuery=kitchen',
  },
  {
    'Men\'s Clothing':
        'https://www.myntra.com/mens-clothing?rawQuery=mens%20clothing',
  },
  {
    'Pet Supplies': 'https://www.myntra.com/pet?rawQuery=pet',
  },
  {
    'Sports': 'https://www.myntra.com/sports?rawQuery=sports',
  },
  {
    'Watches': 'https://www.myntra.com/watches?rawQuery=watches',
  },
  {
    'Women\'s Clothing':
        'https://www.myntra.com/womens-clothing?rawQuery=womens%20clothing',
  },
];
