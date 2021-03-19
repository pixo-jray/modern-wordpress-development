---
theme: gaia
_class: lead
paginate: true
backgroundColor: #eff5f5
backgroundImage: url('/assets/white-top.svg')
backgroundSize: 250%
backgroundPosition: center -20px
style: |
  section pre>code {
    background: #222;
  }
  section.lead h1 {
    color: #002279;
  }
  section.lead h1 strong {
    color: #002279;
  }
  footer {
    height: 80px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    margin-right: 50px
  }
marp: true

---

![bg left:40% 70%](/assets/wordpress-logo.svg)

# **Modern Wordpress Development**

https://pixotech.com

![image](/assets/pixo-logo.svg)

---
<!--
footer: '![image](/assets/pixo-logo.svg)'
-->

<!--
_class: lead
-->
![image](https://pixotech.com/image/build.svg)

---


# A little about me

---
<!--
_class: lead
-->
# Why is this important?

---
<!--
_class: lead
-->
# Developer happiness is important

> Some quote here about something.
 -- Some person
---

# How I got here

* Started as a web designer
* Fell in love with Drupal 
* Learned how to "theme" websites
* Started to get frustrated with Drupal 6 and 7 theming
* Learned how to write object oriented code and MVC frameworks
* Even more frustrated with Drupal
* Started working with Wordpress
* Tried out some MVC principles and they worked!!


--- 
<!--
_class: lead
-->
![image](/assets/wordpress-logo.svg)

Why?

---

![bg right:33% 100%](/assets/kip.gif)
# Why developers like WordPress

* Familiar user interface
* Huge ecosystem 
* Good developer documentation
* Solid core CMS features
* Backward compatibility (Hi Drupal 4-7)

---

# Why developers DON'T like WordPress

* Big hacker target
* Easily misused (too many plugins) 
* Legacy code base
    * Procedural code
    * Difficult to keep DRY
    * Logical code in theming layer

![bg left:33% 100%](/assets/frustrated.gif)

---

# What we want

* **Read code** — We want to read and write code rather than configure a CMS and read project documentation.
* **Write code** — Write small, well named variables, classes and methods that can be easily organized and discovered by others.
* **IDE** — Use the full power of our IDEs.
* **Dev/Test/Prod** — Use environment variables to keep our
  [configuration flexible](https://12factor.net/config) and our projects portable.
  
---

<!--
class: lead
-->

# Let's modernize Wordpress 
# :smile:


---

# First, start with a good foundation

![image](/assets/bedrock.svg)

* Modern directory structure
* Composer-base dependency management
* Environment configuration management

---


```tree
├── composer.json
├── config
│   ├── application.php
│   └── environments
│       ├── development.php
│       ├── staging.php
│       └── production.php
├── vendor
└── web
    ├── app
    │   ├── mu-plugins
    │   ├── plugins
    │   ├── themes
    │   └── uploads
    ├── wp-config.php
    ├── index.php
    └── wp
```

---

```json
{
  "name": "roots/bedrock",
  "type": "project",
  "license": "MIT",
  "description": "WordPress boilerplate with modern development tools, easier configuration, and an improved folder structure",
  "homepage": "https://roots.io/bedrock/",
  "repositories": [
    {
      "type": "composer",
      "url": "https://wpackagist.org",
      "only": ["wpackagist-plugin/*", "wpackagist-theme/*"]
    },
  ],
  "require": {
    "php": ">=7.2",
    "composer/installers": "^1.8",
    "vlucas/phpdotenv": "^4.1.8",
    "oscarotero/env": "^2.1",
    "roots/bedrock-autoloader": "^1.0",
    "roots/wordpress": "^5.6",
    "roots/wp-config": "1.0.0",
    "roots/wp-password-bcrypt": "1.0.0",
    "wpackagist-plugin/redirection":"^5.0",
    "wpackagist-plugin/classic-editor": "^1.5",
  },
  "require-dev": {
    "phpunit/phpunit": "^9.0",
    "wpackagist-plugin/query-monitor": "^3.3"
  }
}
```
---

```php
<?php
/**
 * /config/environments/development.php
 */

use Roots\WPConfig\Config;

Config::define('SAVEQUERIES', true);
Config::define('WP_DEBUG', true);
Config::define('WP_DEBUG_DISPLAY', true);
Config::define('WP_DISABLE_FATAL_ERROR_HANDLER', true);
Config::define('SCRIPT_DEBUG', true);
ini_set('display_errors', '1');

// Enable plugin and theme updates and installation from the admin
Config::define('DISALLOW_FILE_MODS', false);
```
---
```env 
# /.env

# DATABASE CREDENTIALS
DB_NAME=wordpress
DB_USER=wordpress
DB_PASSWORD=wordpress
DB_ROOT_PASSWORD=password
DB_HOST=mariadb

# SECURITY HASHES
AUTH_KEY='000'
SECURE_AUTH_KEY='000'
LOGGED_IN_KEY='000'
NONCE_KEY='000'
AUTH_SALT='000'
SECURE_AUTH_SALT='000'
LOGGED_IN_SALT='000'
NONCE_SALT='000'

# LICENSE KEYS
ACF_PRO_KEY='000'
GRAVITY_FORMS_KEY='000'
```

---

```php
// The way we used to do it.
// functions.php
function create_posttype() {
    register_post_type( 'profile',
        array(
            'labels' => array(
                'name' => __( 'Profile' ),
                'singular_name' => __( 'Profile' )
            ),
            'public' => true,
            'has_archive' => true,
            'rewrite' => array('slug' => 'profile'),
            'show_in_rest' => true,
        )
    );
}
add_action( 'init', 'create_posttype' );
```

---

```php
/* The Lumberjack way 
   app/PostTypes/Profile.php */
namespace App\PostTypes;

use Rareloop\Lumberjack\Post;

class Profile extends Post
{
    public static function getPostType()
    {
        return 'Profile';
    }
    protected static function getPostTypeConfig()
    {
        return [
            'labels' => [
                'name' => __('Profile'),
                'singular_name' => __('Profile'),
                'add_new_item' => __('Add New Profile'),
            ],
            'public' => true,
            'rewrite' => array('slug' => 'profile'),
        ];
    }
}
```

---

Now register the post type

```php
/* Lumberjack
   config/posttypes.php */
return [
    'register' => [
        App\PostTypes\Profile::class,
    ],
];
```

---

# Reading

- [Clean code](https://www.freecodecamp.org/news/clean-coding-for-beginners)
- [12 Factor App](https://12factor.net/)
- [ACF Builder](https://github.com/StoutLogic/acf-builder)
- [Lumberjack](https://lumberjack.rareloop.com/)
- [Bedrock](https://roots.io/bedrock/)


---
