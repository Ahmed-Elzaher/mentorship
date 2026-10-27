# Lumina E-Commerce (mentorship)

A Flutter e-commerce app with email/password authentication, a product catalog, and full English / Arabic localization. Built with a feature-first architecture and Cubit (flutter_bloc) for state management.

## Screenshots

UI designs created in Stitch.

### Onboarding

| Splash | Onboarding 1 | Onboarding 2 | Onboarding 3 |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/splash_screen.png" width="180" alt="Splash"> | <img src="docs/screenshots/onboarding_screen_1.png" width="180" alt="Onboarding 1"> | <img src="docs/screenshots/onboarding_screen_2.png" width="180" alt="Onboarding 2"> | <img src="docs/screenshots/onboarding_screen_3.png" width="180" alt="Onboarding 3"> |

### Authentication

| Login | Register | Verify Account | Forgot Password |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/login.png" width="180" alt="Login"> | <img src="docs/screenshots/register.png" width="180" alt="Register"> | <img src="docs/screenshots/verify_email.png" width="180" alt="Verify Account"> | <img src="docs/screenshots/forgot_password.png" width="180" alt="Forgot Password"> |

| Reset Password |
|:---:|
| <img src="docs/screenshots/reset_password.png" width="180" alt="Reset Password"> |

### Shopping

| Home | Products by Category | Search Filters | No Search Results |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/home.png" width="180" alt="Home"> | <img src="docs/screenshots/products_by_category_screen.png" width="180" alt="Products by Category"> | <img src="docs/screenshots/search_filters_screen.png" width="180" alt="Search Filters"> | <img src="docs/screenshots/no_search_results_discovery_screen.png" width="180" alt="No Search Results"> |

| Product Details | Write a Review | Wishlist |
|:---:|:---:|:---:|
| <img src="docs/screenshots/product_details.png" width="180" alt="Product Details"> | <img src="docs/screenshots/write_a_review_screen.png" width="180" alt="Write a Review"> | <img src="docs/screenshots/wishlist_screen.png" width="180" alt="Wishlist"> |

### Cart & Checkout

| Shopping Cart | Empty Cart | Checkout & Payment | Payment Failed |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/shopping_cart_screen.png" width="180" alt="Shopping Cart"> | <img src="docs/screenshots/empty_cart_recommendations_screen.png" width="180" alt="Empty Cart"> | <img src="docs/screenshots/checkout_payment_screen.png" width="180" alt="Checkout & Payment"> | <img src="docs/screenshots/payment_failed_error_state.png" width="180" alt="Payment Failed"> |

| Order Success & Tracking |
|:---:|
| <img src="docs/screenshots/order_success_tracking_screen.png" width="180" alt="Order Success & Tracking"> |

### Orders

| Order History | Order Details | Return & Refund |
|:---:|:---:|:---:|
| <img src="docs/screenshots/order_history_screen.png" width="180" alt="Order History"> | <img src="docs/screenshots/order_details_screen.png" width="180" alt="Order Details"> | <img src="docs/screenshots/return_refund_request.png" width="180" alt="Return & Refund"> |

### Account

| Profile | Edit Profile | Shipping Addresses | Add Address |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/user_profile_screen.png" width="180" alt="Profile"> | <img src="docs/screenshots/edit_profile_screen.png" width="180" alt="Edit Profile"> | <img src="docs/screenshots/shipping_addresses_screen.png" width="180" alt="Shipping Addresses"> | <img src="docs/screenshots/add_shipping_address_screen.png" width="180" alt="Add Address"> |

| Payment Methods | Vouchers & Offers | VIP Rewards | Notifications |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/payment_methods_screen.png" width="180" alt="Payment Methods"> | <img src="docs/screenshots/my_vouchers_offers.png" width="180" alt="Vouchers & Offers"> | <img src="docs/screenshots/lumina_vip_loyalty_rewards_screen.png" width="180" alt="VIP Rewards"> | <img src="docs/screenshots/notifications_screen.png" width="180" alt="Notifications"> |

### Support & States

| Help & Support | Live Chat | Offline State | Store Prototype |
|:---:|:---:|:---:|:---:|
| <img src="docs/screenshots/help_support_screen.png" width="180" alt="Help & Support"> | <img src="docs/screenshots/live_support_chat.png" width="180" alt="Live Chat"> | <img src="docs/screenshots/network_offline_state.png" width="180" alt="Offline State"> | <img src="docs/screenshots/interactive_prototype_lumina_store.png" width="180" alt="Store Prototype"> |

## Features

- **Authentication**: register, verify email, and log in. Access and refresh tokens are stored locally with `shared_preferences`, and the app opens straight to Home when a token exists.
- **Products**: paginated product list and a product details screen.
- **Localization**: English and Arabic (`lib/l10n`), generated with Flutter's `gen-l10n`.
- **Responsive UI**: sizes adapt to the screen with `flutter_screenutil` (design size 390 x 844), and the Cairo font comes from `google_fonts`.
- **Networking**: a shared `Dio` client with centralized error handling.

## Tech Stack

| Area | Package |
|---|---|
| State management | `flutter_bloc` (Cubit) |
| Networking | `dio` |
| Local storage | `shared_preferences` |
| Responsive sizing | `flutter_screenutil` |
| Fonts | `google_fonts` |
| Localization | `flutter_localizations`, `intl` |

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── localization/   # l10n extension
│   ├── network/        # Dio client + API constants
│   ├── routes/         # route names + router
│   ├── storage/        # token storage
│   ├── theme/          # colors + text styles
│   ├── utils/          # validators, snackbar
│   └── widgets/        # shared widgets (button, text field)
├── features/
│   ├── auth/
│   │   ├── data/           # service + models
│   │   └── presentation/   # cubit + views (login, register, verify email)
│   └── products/
│       ├── data/           # service + models
│       └── presentation/   # cubit + screens (home, product details)
└── l10n/                   # .arb files + generated localizations
```

## Getting Started

### Prerequisites

- Flutter SDK with Dart `^3.13.3`

### Run

```bash
git clone https://github.com/Ahmed-Elzaher/mentorship.git
cd mentorship
flutter pub get
flutter run
```

The localization files are generated automatically (`generate: true` in `pubspec.yaml`). To regenerate them manually:

```bash
flutter gen-l10n
```

### Test

```bash
flutter test
```

## Backend

The app talks to a REST API configured in `lib/core/network/api_constants.dart`:

| Group | Endpoints |
|---|---|
| Auth | `auth/register`, `auth/verify-email`, `auth/login`, `auth/refresh-token` |
| Products | `products`, `products/{id}` |
| Categories | `categories`, `categories/{id}` |

To point the app at a different backend, change `baseUrl` in that file.
