#set text(lang: "ru")
#set text(
    font: "Times New Roman",
    size: 14pt,
  )

#set page(
    paper: "a4",
    // The margins depend on the paper size.
    margin:
      (left: 1.5cm, top: 2.5cm, bottom: 1cm, right: 2cm),
    numbering: "1",
    header: [
        #set text(8pt)
        #smallcaps[Современные языки программирования для анализа данных]
        #h(1fr) Практическая работа
    ]
  )


#set par( 
    // first-line-indent: 1cm,
    justify: true,
    // leading: 1em 
)

#set enum(indent: 10pt, body-indent: 9pt)
#set list(indent: 10pt, body-indent: 9pt)

// #import "./drafting.typ": *

#import "@preview/gentle-clues:0.5.0": clue

#import "@preview/wrap-it:0.1.0": wrap-content


= Установка Julia
Разработчики языка программирования Julia рекомендуют использовать вместо прямой установки конкретной версии интерпретатора использовать менеджер версий `juliaup`. Начнем установку с него. 

== Установка juliaup
=== Установка на Windows

Установка может быть осуществлена как через исполняемый файл, так и через менеджеры пакетов, например, #link("https://winstall.app/apps/Julialang.Juliaup")[winget] или #link("https://apps.microsoft.com/detail/9njnww8pvkmn?rtc=1&hl=en-US&gl=US")[Windows Store].

Для загрузки исполняемого файла необходимо пройти в #link("https://github.com/JuliaLang/juliaup/releases")[репозитарий релизов] и выбрать необходимую версию программы под вашу систему. 

Для установки через исполняемый файл, необходимо скачать подходящую под Windows версию. Это будет файл релиза со следующим названием:

```example
juliaup-VERSION-x86_64-pc-windows-gnu-portable
```
где `VERSION` -- это текущая версия `juliaup`. Внутри будут находиться исполняемые файлы.

=== Установка на Linux/Mac

Для установки `juliaup` можно использовать пакетный менеджер вашей системы. 


=== Работа с `juliaup`

Интерфейс менеджера `juliaup` достаточно прост, для работы потребуется всего несколько команд. Работа с утилитой производится в терминале вашей системы.

#table(columns: (auto, auto),
  [Узнать установленные версии языка], [`juliaup status`],
  [Установить актуальную версию языка], [`juliaup add release`],
  [Задать используемую версию языка в системе (где VERSION это требуемая версия установленная в системе)], [`juliaup default VERSION`], 
  [Удалить версию языка (где VERSION это требуемая версия установленная в системе)], [`juliaup remove VERSION`]
)

Последовательность для установки и настройки релизной версии языка следующая:
- `juliaup add release`
- `juliaup status`, для того что бы узнать какая версия была установлена
- `juliaup default VERSION`, где VERSION это версия, которая была установлена предыдущими командами



== Проверка установки языка 

После установки релизной версии и выбора ее в качестве системной, необходимо проверить правильность установки. Для этого может потребоваться перезагрузка сессии терминала. 

Для проверки, узнаем версию интерпретатора:
```console
julia --version
```
Если Julia установлена корректно, то вывод будет следующим:
```console
julia version VERSION
```
где `VERSION` это установленная версия языка. 
