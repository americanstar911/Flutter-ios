import '../models/product.dart';

const List<Product> products = [
  Product(
    id: 'tabi_1',
    name: 'Tabi Babouches',
    category: 'TABI',
    imagePath: 'assets/images/tabi_1.webp',
    price: 1050,
    rating: 4.8,
    description:
        'Black slip-on shoes with the signature split-toe shape. '
        'A minimal design for a classic everyday look.',
    tags: ['Classic', 'Split toe', 'Black'],
  ),
  Product(
    id: 'tabi_2',
    name: 'Tabi Babouche Suede',
    category: 'TABI',
    imagePath: 'assets/images/tabi_2.webp',
    price: 1190,
    rating: 4.7,
    description:
        'A suede version of the Tabi babouche in a warm neutral shade. '
        'An easy choice for relaxed outfits.',
    tags: ['Classic', 'Suede', 'Brown'],
  ),
  Product(
    id: 'tabi_3',
    name: 'Tabi Loafers',
    category: 'TABI',
    imagePath: 'assets/images/tabi_3.webp',
    price: 1450,
    rating: 4.9,
    description:
        'Black loafers combining a familiar formal shape '
        'with the distinctive Tabi split toe.',
    tags: ['Classic', 'Loafers', 'Black'],
  ),
  Product(
    id: 'replica_1',
    name: 'Replica Sneakers Suede',
    category: 'REPLICA',
    imagePath: 'assets/images/replica_1.webp',
    price: 880,
    rating: 4.8,
    description:
        'Low-top suede sneakers in a neutral brown shade. '
        'A simple silhouette for casual everyday outfits.',
    tags: ['Comfort', 'Suede', 'Low top'],
  ),
  Product(
    id: 'replica_2',
    name: 'Replica Sneakers Blackboard',
    category: 'REPLICA',
    imagePath: 'assets/images/replica_2.webp',
    price: 1150,
    rating: 4.6,
    description:
        'A dark version of the Replica sneaker '
        'with contrasting markings across the upper.',
    tags: ['Comfort', 'Blackboard', 'Black'],
  ),
  Product(
    id: 'replica_3',
    name: 'Replica Sneakers Green',
    category: 'REPLICA',
    imagePath: 'assets/images/replica_3.webp',
    price: 850,
    rating: 4.9,
    description:
        'Green low-top sneakers with light laces '
        'and a contrasting gum-coloured sole.',
    tags: ['Comfort', 'Green', 'Low top'],
  ),
  Product(
    id: 'future_1',
    name: 'Future Sneaker Black',
    category: 'FUTURE',
    imagePath: 'assets/images/future_1.webp',
    price: 1190,
    rating: 4.8,
    description:
        'Black high-top sneakers with a wide ankle strap. '
        'A bold silhouette for expressive outfits.',
    tags: ['Future', 'High top', 'Black'],
  ),
  Product(
    id: 'future_2',
    name: 'Future Sneaker White',
    category: 'FUTURE',
    imagePath: 'assets/images/future_2.webp',
    price: 1190,
    rating: 4.7,
    description:
        'White high-top sneakers with a sculptural shape '
        'and a wide ankle strap.',
    tags: ['Future', 'High top', 'White'],
  ),
  Product(
    id: 'future_3',
    name: 'Future Low-Top',
    category: 'FUTURE',
    imagePath: 'assets/images/future_3.webp',
    price: 1150,
    rating: 4.9,
    description:
        'Black low-top sneakers with a streamlined shape. '
        'A minimal take on the Future collection.',
    tags: ['Future', 'Low top', 'Black'],
  ),
];
