---
theme: gaia
class: lead
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

WebCon - April 8, 2021

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
# A little about me

![bg left:40% 70%](/assets/jason-rambeck.jpg)

I am a lead web developer at Pixo. I work primarily on content management systems and websites - 
especially WordPress.

---

# My journey here

![Falcor from Never ending Story flying](/assets/falcor.gif)

---

## 1. Started as a web designer

![photoshop logo](/assets/photoshop.jpeg)

---

## 2. Got into Drupal

![drupal logo](/assets/drupal.png)

---

## 3. Learned front-end code

HTML, CSS, JS, and some basic PHP

---

## 4. Started getting frustrated with Drupal 

I was fighting with Drupal to produce the front-end code I wanted. 
_It is better today but still a struggle in a lot of ways._

---

## 5. Learned Twig and MVC principles

Twig was such an expressive templating language and made it easier to apply new methodologies like 
[Atomic Design](https://atomicdesign.bradfrost.com/chapter-2/).

---

## 6. Started working with WordPress

After working with WordPress themes in the traditional way I quickly got frustrated and looked for a way
to use Twig.

**I found it!** _Thanks [Timber](https://upstatement.com/timber/)!_

---

## 7. Continued to learn 

* [Clean code](https://www.freecodecamp.org/news/clean-coding-for-beginners) principles
* [12 Factor app](https://12factor.net/) principles
* etc.

---
<!--
_class: lead
-->
# Why is this important?

![doc brown asking why gif](/assets/why.gif)

---

## Separation of concerns

With a robust MVC architecture it is trivial for a front-end developer to theme with very little knowledge of WordPress.

---

## Maintainability :wrench:

- Simply writing more code (vs. UI configuration or plugins)
- Having a framework to organize your code
- Using object-oriented code 

<!--
When functionality is added with more and more plugins and configuration screens it becomes impossible keep track of
how things work.
-->

---
<!--
_class: lead
-->

## Developer happiness is important :grin:

We cannot overstate the importance of enjoying our work.
<br>
**"A happy developer is a productive developer"**

--- 
<!--
_class: lead
-->
![wordpress logo w:200px](/assets/wordpress-logo.svg)

## Why Wordpress?

---

![bg left:33% 100%](/assets/kip.gif)
## Why we like WordPress

* Familiar user interface
* Huge ecosystem 
* Good developer documentation
* Solid core CMS features
* Backward compatibility (Hi Drupal 4-7)

---

## Why developers DON'T like WordPress

* A hacker target
* Easily misused (too many plugins) 
* Legacy code base
    * Procedural code
    * Difficult to keep [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) (Don't Repeat Yourself)
    * Logical code in theming layer

![bg left:33% 100%](/assets/frustrated.gif)

---

# What we want

* **Read code** — We want to read and write code rather than configure a CMS and read project documentation.
* **Write code** — Write small, well named variables, classes and methods that can be easily organized and discovered by others.
* **IDE** — Use the full power of our IDEs.
* **Dev/Test/Prod** — Use environment variables to keep our
  [configuration flexible](https://12factor.net/config) and our projects portable.
  
<!--
- Read: Have you ever inherited a CMS project that was a mess of plugins and configuration. We can read and discover code much easier configuration in a UI.
- Write: I remember the first time someone told me they didn't use the Views module in a Drupal project.
- IDE: When you write modern code your IDE becomes invaluable.
- DEV/TEST/PROD: Check out the 12 Factor App principles.
-->

---

<!--
class: lead
-->

# <!--fit--> Let's modernize Wordpress 
# :smile:


---

# First, start with a good foundation

![width:500px](/assets/bedrock.svg)

1) Modern directory structure
2) Composer-based dependency management
3) Environment configuration management

---

# Directory structure
## WordPress standard vs. Bedrock

---

```bash
project/
├── index.php
├── license.txt
├── readme.html
├── wp-activate.php
├── wp-admin/
├── wp-blog-header.php
├── wp-comments-post.php
├── wp-config-sample.php
├── wp-content/
│   ├── index.php
│   ├── plugins/
│   └── themes/
├── wp-cron.php
├── wp-includes/
├── wp-links-opml.php
├── wp-load.php
├── wp-login.php
├── wp-mail.php
├── wp-settings.php
├── wp-signup.php
├── wp-trackback.php
└── xmlrpc.php
```

<!--
- It is a flat structure.
- The web root is the project root.
-->

---
<!---
* Web root is no longer the project root. Allows for code, config, and documentation that is not exposed to the web server
* `wp-content/` is now `app/` 
--->

```bash
project/
├── config/
│   ├── environments/
│   │   ├── development.php
│   │   ├── staging.php
│   │   └── production.php
│   └── application.php   # Primary wp-config.php
├── vendor/               # Composer dependencies
└── web/                  # Virtual host document root
    ├── app/              # WordPress content directory
    │   ├── mu-plugins/
    │   ├── plugins/
    │   ├── themes/
    │   └── uploads/
    └── wp/               # WordPress core
```
---

# Dependency management

```bash
wp plugin install redirection   # Install a plugin and commit the code
wp plugin update redirection    # Update a plugin
```
## vs.
```bash
composer require 'wpackagist-plugin/redirection'  # Install a plugin
composer outdated                                 # Check for updates
composer update 'wpackagist-plugin/redirection'   # Update a plugin 
```

<!-- 
- WP-CLI is a powerful tool and allowed developers to manage plugins from the command line.
- Bedrock takes it to the next level and allows dependency management that is standard for PHP using Composer.
- All packages hosted on Wordpress.org have a WPackagist package.
- Github only packages can be added as well.
-->

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


# WordPress standard configuration management

NOPE. There is no built-in way to manage configuration for each environment.

---

Here is how we used to do it.

---

```php
/**
 * /wp-config.php
 */
if (file_exists(dirname(__FILE__) . '/wp-config-local.php'))
        require_once(dirname(__FILE__) . '/wp-config-local.php');
/**
 * /wp-config-local.php
 */
define('DB_NAME', 'wordpress');
define('DB_USER', 'wordpress');
define('DB_PASSWORD', 'wordpress');
define('DB_HOST', 'mariadb');

define('AUTH_KEY', 'fill-in');
define('SECURE_AUTH_KEY', 'fill-in');
define('LOGGED_IN_KEY', 'fill-in');
define('NONCE_KEY', 'fill-in');
...

define('WP_DEBUG', true);
define('WP_DEBUG_DISPLAY', true);
define('DISALLOW_FILE_MODS', true);
```

---

Bedrock replaces `wp-config-local.php with` separate environment variable and configuration methods.

---

# The .env file

The modern standard for storing environment variables is the `.env` file. Now we can have it in WordPress.
All thanks to Bedrock's implementation of the `phpdotenv` [package](https://github.com/vlucas/phpdotenv).

---

```bash
# /.env

# PROJECT SETTINGS
PROJECT_NAME=example
PROJECT_TITLE="Example Project"
PROJECT_BASE_URL=example.localhost
# DATABASE CREDENTIALS
DB_NAME=wordpress
DB_USER=wordpress
DB_PASSWORD=wordpress
DB_HOST=mariadb
# Environment
WP_ENV=development
WP_HOME=http://${PROJECT_BASE_URL}
WP_SITEURL=${WP_HOME}/wp
# SECURITY HASHES
AUTH_KEY='000'
SECURE_AUTH_KEY='000'
LOGGED_IN_KEY='000'
...
# LICENSE KEYS
ACF_PRO_KEY='fill-in'
GRAVITY_FORMS_KEY='fill-in'
```

<!--
We can and do use the .env file for more than just WordPress.
-->

---

# Environment configuration

---

```php
<?php
/**
 * /config/environments/development.php
 */

use Roots\WPConfig\Config;

Config::define('WP_DEBUG', true);
Config::define('WP_DEBUG_DISPLAY', true);
Config::define('WP_DISABLE_FATAL_ERROR_HANDLER', true);
Config::define('SCRIPT_DEBUG', true);
ini_set('display_errors', '1');
Config::define('DISALLOW_FILE_MODS', false);
```
---

# Templating

Timber adds Twig templating with an MVC structure to WordPress themes.

![width:500px](/assets/timber.svg)

---

Let's start by creating a **viewmodel**!

---

```php
<?php

namespace App\ViewModels;

class NewsArticleViewModel
{
    public static function createFromPost($post)
    {
        $viewModel = new NewsArticleViewModel();

        $viewModel->title = $post->title;
        $date = new \DateTime($post->post_date);
        $viewModel->publicationDate = $date->format('F d, Y');
        $viewModel->introduction = get_field('introduction');

        return $viewModel;
    }
}
```
<!-- 
We are starting with just some basic PHP code to create our viewmodel object from the WP Post.
-->

---

Now create the **view** using Twig.

---

```twig
{# pages/news-article.twig #}
{% extends "templates/base.twig" %}

{% block content %}
    <div class="news-article-page">
        <h1 class="news-article-page__title">
          {{ post.title }}
        </h1>
        <div class="news-article-page__date">
          {{ post.publicationDate }}
        </div>
        {% if post.introduction %}
        <div class="news-article-page__introduction">
          {{ post.introduction }}
        </div>
        {% endif %}
        <div class="news-article-page__body">
          {{ post.body }}
        </div>
    </div>
{% endblock %}
```

---

Finally, let's hook it all up with our controller.

---

```php
<?php

/**
 * single-news.php
 */

namespace App;

use App\Http\Controllers\Controller;
use Rareloop\Lumberjack\Http\Responses\TimberResponse;
use Rareloop\Lumberjack\Post;
use Timber\Timber;

class SingleNewsController extends Controller
{
    public function handle()
    {
        $context = Timber::get_context();
        $post = new Post();

        $context['post'] = NewsArticleViewModel::createFromPost($post);

        return new TimberResponse('patterns/pages/news-article.twig', $context);
    }
}
```

---

# Traditional WordPress templating

Compare this to a traditional version of the same template where everything is in the **controller**.

---

```html
/*
 * single-news.php
 */
<div class="news-article-page">
    <h1 class="news-article-page__title">
        <?php the_title(); ?>
    </h1>
    <?php 
        $date = new /DateTime(the_date());
        $publicationDate = $date->format('F d, Y'); 
    ?>
    <div class="news-article-page__date">
          <?php echo $publicationDate; ?>
    </div>
    <?php
        if (get_field('introduction')) {
	        echo '<div class="news-article-page__introduction">' . get_field('introduction') . '</div>';
        }
    ?>
    <div class="news-article-page__body">
          <?php echo get_field('body'); ?>
    </div>

</div> 

```

---


# Atomic design 

Now that we have pulled out the templates from WordPress template files we are free to organize our templates
in a way that supports our [Atomic Design](https://atomicdesign.bradfrost.com/chapter-2/) methodology.


---

```bash
/web/app/themes/custom/patterns
├── bits
│   └── button
│       ├── button.config.js
│       ├── button.styl
│       └── button.twig
├── components
│   └── image
│       ├── image.config.js
│       ├── image.styl
│       └── image.twig
│   └── text
│       ├── text.config.js
│       ├── text.styl
│       └── text.twig
├── pages
│   ├── landing
│   |   ├── landing.config.js
│   │   ├── landing.styl
│   │   └── landing.twig
├── partials
│   └── news-card
│       ├── news-card.config.js
│       ├── news-card.styl
│       └── news-card.twig
└── templates
│   └── base
│       ├── base.config.js
│       ├── base.styl
│       └── base.twig
```

---

![Fractal pattern library screenshot width:800px](/assets/fractal.png)

[Fractal](https://fractal.build/) pattern library.

---

![Lumberjack project logo width:500px](/assets/lumberjack.svg)

Lumberjack is a framework for your theme that allows you to _"write better, more expressive and easier to maintain code."_

It builds on the foundation of **Bedrock** and **Timber**.

<!--
- Lumberjack is a theme-based framework. 
- The packages are all Composer dependencies.
-->

---

Lumberjack supports...

* Creating/registering post type objects
* WP Query builder
* Registering menus
* Defining custom routes
* ...much more

---

# Registering a custom post type

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

## Query builder

---

```php
// How we used to do it.
/* Set the WP_Query arguments */
$args = array(
	'post_type'              => array( 'project' ),
	'order'                  => 'ASC',
	'orderby'                => 'title',
);

/* The Query */
$query = new WP_Query( $args );
```

---

```php
// The Lumberjack way
use App\PostTypes\Project;

$projects = Project::builder()->get();

dump($projects);

/*
    Collection {
        #items: array:2 [
            0 => App\PostTypes\Project,
            1 => App\PostTypes\Project,
        ]
    }
*/
```

---

```php
use App\PostTypes\Project;

$projects = Project::builder()
    ->orderBy('title', 'asc')
    ->limit(3)
    ->get();
```

<!--
You now have about a dozen chainable methods available to configure your query.
Your IDE knows all about these methods and can autocomplete and hint at the parameters.
Your IDE cannot help you figure your $args array.
-->

---

```php
use App\PostTypes\Project;
use App\PostTypes\CaseStudy;
use Rareloop\Lumberjack\QueryBuilder;

$posts = (new QueryBuilder)->wherePostType([
    Project::getPostType(),
    CaseStudy::getPostType(),
])
->orderBy('date', 'asc')
->get();
```

---

### Scoped queries

---

```php
namespace App\PostTypes;

use Rareloop\Lumberjack\Post as LumberjackPost;

class Post extends LumberjackPost
{
    ...

    public function scopeFeatured($query)
    {
        $featuredPostIds = [1, 2];
        return $query->whereIdIn($featuredPostIds);    
    }
}

// page.php
// Get the latest 3 featured posts
$posts = Post::featured()
    ->orderBy('date', 'desc')
    ->limit(3)
    ->get();
```

---

## Register menus

---

```php
<?php

return [
    /**
     * config/menus.php 
     * List of menus to register with WordPress during bootstrap
     */
    'menus' => [
        'main-nav' => __('Main Navigation'),
        'footer' => __('Footer Navigation')
    ],
];
```

<!-- 
Registering menus is not difficult in Wordpress.
However, just have a single location to register them and abstracting away the Wordpress method into
a simple array is so much nicer.
-->

---

## Custom routes

---

```php
// routes.php
Router::get('path/to/page', 'TestController@show');

// app/Http/Controllers/TestController.php
namespace App\Http\Controllers;

class TestController
{
    public function show()
    {
        return 'Hello World';
    }
}
```

---

# Advanced Custom Fields (ACF)

![image](/assets/acf-pro.png)

---

# Wait? What about Gutenberg

* It is not good for MVC (yet)
* Block are stored as a blob of data, markup, and HTML comments
* Not very useful as structured data

<!--
- ACF has support for making Gutenberg blocks using ACF fields that is more structured.
- But there are other challenges with Gutenberg that keep us from adopting it.
- We still prefer the ACF Flexible Content model.
-->

---

# Registering ACF fields, the old way

* Use the UI and exports a JSON file.
* Export PHP and find a good place for it.

---

![ACF fields UI screenshot width:800px](/assets/acf-ui.png)

---

```php
<?php 
/* functions.php */
acf_add_local_field_group([
    'key' => 'group_1',
    'title' => 'My Group',
    'fields' => array (
        array (
            'key' => 'field_summary',
            'label' => 'Summary',
            'name' => 'Summary',
            'type' => 'textarea',
        ),
        array (
            'key' => 'field_categories',
            'label' => 'Categories',
            'name' => 'categories',
            'type' => 'checkbox',
            'width' => '33%',
            'choices' => array (
                array (
                    'faculty_staff' => 'Faculty & Staff',
                    'community_impact' => 'Community Impact',
                    'professional_development' => 'Professional Development',
                )
            )
        )
    ),
    'location' => array (
        array (
            array (
                'param' => 'post_type',
                'operator' => '==',
                'value' => 'post',
            ),
        ),
    ),
    'menu_order' => 0,
    'position' => 'normal',
    'style' => 'default',
    'label_placement' => 'top',
    'instruction_placement' => 'label',
]);
```

<!--
Just one big specially formatted PHP object.
-->

---

# Enter... ACF Builder

![image](/assets/acf-pro.png)

https://github.com/StoutLogic/acf-builder

---

```php
<?php

use App\ACF\FieldsBuilder;
use App\PostTypes\News;

$builder = new FieldsBuilder('news');

$builder->setLocation('post_type', '==', News::getPostType());

$builder->addRichText('summary')
    ->setLabel('Summary')
    ->setInstructions('A summary (about 25 words) of the article.')
    ->setRequired();

$builder->addCheckbox('categories')
    ->addChoice('Faculty & Staff')
    ->addChoice('Community Impact')
    ->addChoice('Professional Development')
    ->setWidth('33%')
    ->setInstructions('Select all categories that apply.');

return $builder;


```

<!--
- Chainable methods.
- Very powerful and verbose methods.
- Sane defaults.
- Extendable field types.
-->

---

![Screenshot of IDE hints width:1000px](/assets/acf-ide.png)

---

# Live Demo time

---

# Q & A

---

# Reading

- [Clean code](https://www.freecodecamp.org/news/clean-coding-for-beginners)
- [12 Factor App](https://12factor.net/)
- [ACF Builder](https://github.com/StoutLogic/acf-builder)
- [Lumberjack](https://lumberjack.rareloop.com/)
- [Bedrock](https://roots.io/bedrock/)
- ...and alternative frameworks
- [Carbon Fields](https://carbonfields.net/)
- [WP Emerge - Wordpress MVC framework](https://github.com/htmlburger/wpemerge)


---

# Fin

Follow or connect with me on [LinkedIn](https://www.linkedin.com/in/jasonrambeck).

---