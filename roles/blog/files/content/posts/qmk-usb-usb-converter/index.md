---
title: 'QMK USB-USB конвертер - сборка'
date: 2022-01-29T17:19:49Z
draft: false
description: Небольшой гайд по сборке USB-USB QMK конвертера - приблуды, которая позволяет подружить с QMK всякие не умеющие в QMK клавиатуры (не все, но всякие).
tags: ['RU', 'keyboards']
---

Небольшой гайд по сборке USB-USB QMK конвертера - приблуды, которая позволяет подружить с QMK всякие не умеющие в QMK клавиатуры (не все, но всякие).

Мне оригинал гайда показался не совсем понятным, поэтому пишу, чтобы не забыть процесс.

[Контроллер в репозитории QMK](https://github.com/qmk/qmk_firmware/tree/master/keyboards/converter/usb_usb)

### Дисклеймеры

- Этот конвертер придумал не я, вот [оригинал инструкции.](https://geekhack.org/index.php?topic=80421.0)
- Ссылки на али дал те, по которым брал сам, наверняка есть ещё миллион лотов с такими же товарами.

### Итак, поехали

Нам понадобится:

- **3.3v** промикра с гребёнкой. Именно 3.3 вольта - с обычными 5вольтовым не заработает. Например [вот этот.](https://aliexpress.ru/item/1871481789.html?spm=a2g0s.9042311.0.0.264d33ed3qbb8T)
- USB Host Shield для ардуины. Например [этот](https://aliexpress.ru/item/32942427334.html?spm=a2g0s.9042311.0.0.264d33edfImOOY)
- Всякий стаф для пайки
- Пару тонких проводков
- Острый нож

{{< image src="img/1.jpg" position="center" style="border-radius: 8px; width: 50%; height: 50%" >}}  
_Наши подопытные - промикра и host shield_

### Процесс

#### Семь раз отмерь

На всякий случай проверяем, что наша промикра на 3.3 вольта (а то они все на одно лицо). Для этого можно измерить напряжение между пинами VCC и GND

{{< image src="img/2.jpg" position="center" style="border-radius: 8px; width: 50%; height: 50%" >}}

Далее прошиваем промикру, чтобы проверить её рабочесть. Потом выпаивать совсем не захочется. Для этого клонируем себе репозиторий QMK, ставим нужные зависимости и заливаем вот эту штуку

```
$ sudo make converter/usb_usb/pro_micro:default:avrdude
```

Нам нужен `pro_micro` вариант.

Также сравниваем частоту своей промикры с тем, что написано в `keyboards/converter/usb_usb/pro_micro/rules.mk`. Если промикра на 16мгц а в конфиге `F_CPU = 8000000` - надо будет поменять на 16.

#### Один раз отрежь

Режем вот эту дорожку на шилде (выделил розовым, открываем картинку в новой вкладке для полного размера). Режем без жалости и проверяем уничтожение прозваниванием - если резать так, как в оригинале, то есть шанс ничего не разрезать и потом мучительно всё выпаивать назад.

{{< image src="img/3.jpg" position="center" style="border-radius: 8px; width: 50%; height: 50%" >}}

Напаиваем гребёнки на шилд вот в такой конфигурации

{{< image src="img/4.jpg" position="center" style="border-radius: 8px; width: 50%; height: 50%" >}}

Прокидываем два провода на внутренней стороне шилда

1. Провод от того пада, где мы резали дорожку, до RAW пина промикры
2. Провод, замыкающий два контакта на шилде. С одной гребёнки можно пассатижами снять пластмассовую часть, чтобы не мешалась.

{{< image src="img/6.jpg" position="center" style="border-radius: 8px; width: 50%; height: 50%" >}}

В итоге промикра будет лежать на гребёнке как-то так.

{{< image src="img/5.jpg" position="center" style="border-radius: 8px; width: 50%; height: 50%" >}}

#### Проверяем

Клавиатуру - в USB порт на шилде, потом промикру подключаем к компьютеру (наоборот оно не заводится).

Радуемся.
