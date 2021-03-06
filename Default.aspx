﻿<%@ Page Title="DEFAULT" Language="C#" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="Default" %>


<!doctype html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

  <title>Меломан iPhone app</title>
  <meta name="description" content="Меломан iPhone app - Flatsoft, LLC">
  <meta name="author" content="Flatsoft, LLC">
  <link rel="icon" href="icon.ico" type="image/x-icon">
  <link rel="shortcut icon" href="icon.ico">
  <link rel="apple-touch-icon" href="icon.png" />
  <meta name="viewport" content="width=device-width, user-scalable=yes, minimum-scale=0, maximum-scale=1.0" />
  <link href='http://fonts.googleapis.com/css?family=Lobster&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=PT+Sans+Narrow&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="Styles/style.css">
  <script src="js/libs/modernizr-2.0.6.min.js"></script>
</head>

<body>

  <div id="container">
    <header>
      <div class="wrap clearfix">
        <div class="iphone">
          <div class="label"></div>
          <div class="reflection"></div>
          <div class="slides">
            <ul>
              <li><img src="content/slide1.png" alt="Загрузка приложения..." /></li>
              <li><img src="content/slide2.png" alt="Авторизация" /></li>
              <li><img src="content/slide3.png" alt="Авторизация..." /></li>
              <li><img src="content/slide4.png" alt="Синхронизация..." /></li>
              <li><img src="content/slide5.png" alt="Список песен" /></li>
              <li><img src="content/slide6.png" alt="Проигрывание песни" /></li>
              <li><img src="content/slide7.png" alt="Добавление в избранное" /></li>
              <li><img src="content/slide8.png" alt="Добавление в избранное" /></li>
            </ul>
          </div>
        </div>
        <img src="content/logo/logo.png" alt="Меломан" width="426" height="93" class="logo" />
        <h3>Музыкальное приложение для iPhone</h3>
        <h1>Слушай любимую музыку<br>из сети ВКонтакте<br>без подключения к интернету!</h1>
        <nav class="clearfix">
          <a href="http://itunes.apple.com/ru/app/id496224452"><img src="content/appstore.png" alt="Available on the iPhone App Store" width="154" height="51" /></a>
          <h1 class="video-link"><a href="#main">Видео<img src="content/arrow.png" alt="" width="11" height="18" /></a></h1>
        </nav>
      </div>
    </header>
    <div id="main" role="main">
      <div class="wrap">
        <section class="clearfix">
          <div class="demo">
            <h2>Твои любимые песни теперь всегда будут<br>с тобой!</h2>
            <p>Приложение “Меломан” позволяет просто получить доступ к вашим песням ВКонтакте, чтобы наслаждаться ими дома или в дороге, даже без подключения к интернету.</p>
            <p>Простота и бесплатность вот, что отличает наше приложение от аналогов.</p>
          </div>
          <div id="video">
            <iframe width="620" height="350" src="http://www.youtube.com/embed/7Dkllj1GbQU?rel=0" frameborder="0" allowfullscreen></iframe>
          </div>
        </section>
        <section class="steps">
          <ul class="clearfix">
            <li>
              <h3>Авторизация</h3>
              <img src="content/screen1.png" alt="Авторизация" />
              <h4>Введите логин  <br>и пароль от вашего аккаунта ВКонтакте</h4>
              <p>Введите логин и пароль от вашего аккаунта ВКонтакте, чтобы приложение могло получить доступ к списку ваших песен. Пароль надежно хранится в защищенной системе iPhone.</p>
            </li>
            <li>
              <h3>Список песен</h3>
              <img src="content/screen2.png" alt="Список песен" />
              <h4>Список песен из<br>вашего аккаунта ВКонтакте, автоматически обновляется,<br>стоит лишь<br>потянуть за него.</h4>
            </li>
            <li>
              <h3>Прослушивание</h3>
              <img src="content/screen3.png" alt="Прослушивание" />
              <h4>Просто нажмите<br>на заголовок песни,<br>чтобы прослушать</h4>
            </li>
            <li>
              <h3>Избранные песни</h3>
              <img src="content/screen4.png" alt="Избранные песни" />
              <h4>Нажмите на<br>звездочку (<img src="content/star.png" alt="Избранное" class="star" />), дождитесь пока индикатор<br>не зафиксирует завершение процесса<br>и наслаждайтесь любимыми песнями<br>в оффлайне.</h4>
            </li>
            <li>
              <h3>Настройки</h3>
              <img src="content/screen5.png" alt="Настройки" />
              <h4>Вы можете изменить аккаунт ВКонтакте, просмотреть сколько места используется<br>для избранных песен.</h4>
            </li>
          </ul>
        </section>
        <footer>
          <p><a href="http://flatsoft.com">&copy; Flatsoft</a></p>
        </footer>
      </div>
    </div>
  </div>
  <script src="//ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js"></script>
  <script>      window.jQuery || document.write('<script src="Scripts/jquery-1.6.2.min.js"><\/script>')</script>
  <script defer src="js/plugins.js"></script>
  <script defer src="js/script.js"></script>
  <!--[if lt IE 7 ]>
    <script src="//ajax.googleapis.com/ajax/libs/chrome-frame/1.0.3/CFInstall.min.js"></script>
    <script>window.attachEvent('onload',function(){CFInstall.check({mode:'overlay'})})</script>
  <![endif]-->

</body>
</html>
