---
theme: gaia
_class: lead
paginate: true
backgroundColor: #eff5f5
backgroundImage: url('https://pixotech.com/image/top/white-top.svg')
backgroundSize: 250%
backgroundPosition: center -20px
style: |
  section.lead h1 {
    color: #002279;
  }
  section.lead h1 strong {
    color: #002279;
  }
  footer {
    height: 100px;
    display: flex;
    align-items: center;
    justify-items: flex-end;
  }
marp: true

---

![bg left:40% 70%](/assets/wordpress-logo.svg)

# **Modern Wordpress Development**

https://github.com

![image](https://pixotech.com/image/logo.svg)

---
<!--
footer: '![image 100px](https://pixotech.com/image/logo.svg)'
-->

<!--
_class: lead
-->
![image](https://pixotech.com/image/build.svg)

---


# A little about me

* Started as a web designer
* Fell in love with Drupal 
* Learned how to "theme" websites
* Started to get frustrated with Drupal 6 and 7 theming
* Learned how to write code
* Even more frustrated with Drupal


--- 

# Why not xyz new CMS?

Good question. 

We do. But WordPress is still great for many projects.

- Strapi
- Custom CMS

---

# Why developers like WordPress

* Familiar user interface
* Huge ecosystem 
* Good developer documentation
* Solid core CMS features
* Backward compatibility (Hi Drupal 4-7)

---

# Why developers DON'T like WordPress

- Big hacker target
- Easily misused (too many plugins) 
- Legacy code base
    - Procedural code
    - Difficult to keep DRY
    - Logical code in theming layer

---
# Don't use plugins very much
---
# Some code

```php
namespace App\PostTypes;

use Rareloop\Lumberjack\Post;

class Product extends Post
{

    public static function getPostType()
    {
        return 'products';
    }

    protected static function getPostTypeConfig()
    {
        return [
            'labels' => [
                'name' => __('Products'),
                'singular_name' => __('Product'),
                'add_new_item' => __('Add New Product'),
            ],
            'public' => true,
        ];
    }
}
```

---
