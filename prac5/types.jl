### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# ╔═╡ b8645372-eb92-11ef-19f7-4d4d54d26f36
md"""
# Практическая работа

## Множесвенная диспетчеризация

> Множественная диспетчеризация — это концепция в программировании, при которой вызываемая функция (или метод) определяется не только по имени функции, но и по количеству аргументов или их типам. Это позволяет иметь несколько функций с одинаковым именем, но различающихся по списку параметров или типу аргументов

В Julia очень широко и часто используется множественная диспетчеризация и для того чтобы разобраться в том, как она работает начнем рассматривать все пошагово
"""

# ╔═╡ 9f0e904b-6fa0-480d-9350-9fc29041e1dc
md"""
Обьявляем функцию
"""

# ╔═╡ 819574e3-abb3-458b-b80d-1946317f4249
f(x) = x.^2

# ╔═╡ 42074e33-a14c-483a-a079-2629f9f011ea
md"""
Внимательнее посмотрим на то, что вернул нам интерпретатор `f (generic function with 1 method)`, что означает, что сигнатура функции не определена. Теперь, если мы вызовем эту функцию, передав аргумент, Julia вынуждена будет сама определить тип аргумента и сигнатуру функции
"""

# ╔═╡ 2defc4c7-e1ed-4c35-bb46-4defbff870cb
f(2)

# ╔═╡ e63dadb6-9241-46bf-b246-3c5293a525f7
f(1:10)

# ╔═╡ 2556e069-349f-4820-8f43-9f6ef0e5d387
md"""
Но мы можем подсказать ожидаемые типы для функции. Это с одной стороны, позволит специфицировать поведение функции для конкретного типа, а с другой, применить к такой функции различные оптимизации, ускоряющие ее исполнение. Для этого используется синтаксис `Имя::Тип`. Типизируем функцию
"""

# ╔═╡ b2ea72a2-e878-41b2-a291-1bf20d0eeb84
f2(x::Int) = x ^ 2

# ╔═╡ d7144a26-3344-4dcd-90df-c1ca02649e6c
md"""
Теперь, если вызвать эту функцию с любым другим типом данных, то это вызовет ошибку
"""

# ╔═╡ baad34dd-4998-4f7a-92cc-7ac3ad3ae01c
md"""
Теперь мы можем определить вторую функцию с таким же именем, но другими типами аргументов
"""

# ╔═╡ eb3cddad-146a-4ff0-960a-5e9b8218a608
typeof(1:10)

# ╔═╡ a39532dd-622b-411f-952a-8676f66e6c57
f2(x::UnitRange) = x .^ 2

# ╔═╡ e3bb901a-f24f-4879-9183-a799091b8525
f2(2)

# ╔═╡ 3824ff40-fba8-4bce-9b30-3509ea91d294
f2("42")

# ╔═╡ 29181c1c-3f72-4158-9c0b-e3f6c4689f3c
md"""
Теперь вывод интерпрератора изменился и указано, что у функции есть два метода
"""

# ╔═╡ fb4ab5e3-ea8b-4fe5-8ae6-da4584e448f7
f2(1:10)

# ╔═╡ 6c17efde-1d94-4872-a2cc-1e929a474f06
md"""
Так что же такое `generic method`? Это абстракция над каким-то поведением. Например, фукнкция `+` это абстракция над операцией сложения, которая для разных данных может производиться по разным правилам. 
Метод же это конкретная реализация обобщенной функции (generiс method) для конкретного набора аргументов (их типов). Например, операция `+` реализована в множестве методов с самой разной сигнатурой: вещественные числа, целые числа, матрицы и т.д.

Для того чтобы узнать какие и сколько методов ассоциированны с обобщенной функцией служит функция `methods`
"""

# ╔═╡ 586ac0c0-2524-4c55-a766-6441e5eea175
methods(f2)

# ╔═╡ 096c1705-0a22-47b8-a79a-0ae55386d968
md"""
Для того чтобы узнать какой метод будет вызван для конкретных аргументов, можно использовать макрос `@which`
"""

# ╔═╡ 2c7c5c2d-27b2-4ed2-8af8-9d6cca3a0136
@which f2(1:20)

# ╔═╡ df05f2cd-cc9c-4c12-8924-96941abaabb0
md"""
Рассмотрим более сложно типизированный метод. Например, какой метод будет вызван для сложения двух чисел разных типов?
"""

# ╔═╡ 94734391-8116-4637-9268-555fbda36d4d
@which 3.0 + 3

# ╔═╡ 67b06359-fb3e-4751-b638-b43f4bd32d57
md"""
# Задания
"""

# ╔═╡ 573849d7-7ba7-4209-8806-9ba6dd4660b2
md"""
## Задание 1
Реализуйте функцию `quad(q)` умножающую аргумент на 4 для нескольких типов аргументов:
- целых чисел
- вещественных чисел
- любых чисел
- диапазонов значений
- векторов
"""

# ╔═╡ a076363d-14df-49ec-9f98-8f75a013f39f
md"""
## Типы в Julia

Программы в Julia манипулируют значениями и каждое значение имеет две составляющие: его тип и его данные. Тип отвечает на вопрос "что это такое", а данные на "какое конкретное значение записано". Узнать тип любого значения можно, вызвав функцию `typeof`
"""

# ╔═╡ 8678e9bb-79af-4bc3-8904-db5f7499090e
typeof(3)

# ╔═╡ 2cd7bf92-6035-43e5-b65f-fb2895278c63
typeof(3e100)

# ╔═╡ 57d3396b-eb16-4803-9f97-12258aa0f4d6
md"""
В Julia типы также могут быть значениями (в том смысле, что их можно передавать и присваивать)
"""

# ╔═╡ da8e1b55-a0b6-45b6-ad02-b0084802e950
typeof(Int)

# ╔═╡ cef20443-7388-40ae-ad88-e8953d78b632
typeof(DataType)

# ╔═╡ 52a61d3e-91d3-4187-b284-c385a7adf5a4
md"""
Судя по всему, тип `Int` это что-то что относится к `DataType` значениям. Но если попытаться узнать, что к какому типу относится сам `DataType`, то интерпретатор скажет, что это `DataType`. Почему такое происходит?

Дело в том, что `DataType` это базовый тип в системе типов Julia и он замыкает цепочку зависимостей типов, являясь предком для всех типов-значений. 
"""

# ╔═╡ b9225b3b-b077-4e62-8b94-30047f981ba1
E = typeof(1+2im)

# ╔═╡ 1ef3a217-5635-432e-89bf-f76cfabe4819
E.name

# ╔═╡ 33d99839-753e-4ae1-b6e5-41c13fe8f31f
E.parameters

# ╔═╡ d7ffe6b6-8932-49cc-ac44-edb4fe363b98
md"""
У типов так же есть параметры. Например, для комплексных чисел параметры это вектор целых чисел: компоненты комплексного числа. 

Можно выяснить отношения типов узнав супер-тип. Узнаем, что является самым базовым типом в системе типов Julia
"""

# ╔═╡ bb8943d2-903f-4285-ba61-224c3ef40879
E.super

# ╔═╡ 834528dc-e389-44b7-81ea-307bb461d512
E.super.super

# ╔═╡ 61decaf6-04c0-4032-ae11-c6446078cb7b
E.super.super.super

# ╔═╡ e58a5b40-ed92-40ca-a283-f305a5488b5a
md"""
Как мы можем увидеть, самым верхнеуровневым типом в цепочке наследования является тип `Any`
"""

# ╔═╡ a584722e-536f-4802-af99-e912001f7c7f
md"""
Какие типы, являются компонентами данного типа, если он составной:
"""

# ╔═╡ fd547053-dfc7-45d2-b5f7-89d52097abef
E.types

# ╔═╡ 6710d5b4-28fa-4f62-be52-b44d62b22f47
md"""
Какие имена есть у компонентов типа, если он составной
"""

# ╔═╡ acc8ddc5-d81a-4071-bdd9-19eb154e6850
E.name.names

# ╔═╡ b96510f0-a982-4914-8119-d853df64471a
md"""
Изменяемы ли значения данного типа
"""

# ╔═╡ 1e63763c-be01-4a4b-8b4d-6ad9296acddf
ismutable(E)

# ╔═╡ 93ea4e16-e120-455a-ba1f-0c8bbe49e147
isabstracttype(E)

# ╔═╡ 51d3ca4e-ab62-458e-ba8a-7c3948a05c5d
E.layout

# ╔═╡ bc9f839c-1442-451b-97eb-57b00fe02ba1
md"""
Полученный результат `Ptr{Nothing} @0x00007ffb7f8afbc0` указывает на то, что сведения о расположении (layout) данного типа находятся в памяти по определенному адресу. 

Это деталь реализации языка Julia, показывающая, как информация о типе хранится и обрабатывается в рантайме. `Ptr{Nothing}` означает, что это указатель на место в памяти, где хранится специфичная для типа информация, такая как его layout, но сам указатель не указывает на данные конкретного типа.
"""

# ╔═╡ ee873619-9d91-4dba-95e9-4f1dee8383cd
md"""
В Julia существует возможность создавать свои собственные типы, как простые, так и составные (состоящие из нескольких других типов)
"""

# ╔═╡ fc401300-2ca8-43c5-8a0b-e01dd2a4d20e
struct Point
	x::Float64
	y::Float64
end

# ╔═╡ ea1e43d1-910a-4cd1-98d3-8ec1b19af7a3
Point(1, 3)

# ╔═╡ 038aa323-6c5b-4a37-beab-ead9c8779566
typeof(Point)

# ╔═╡ fab65f67-a386-40b9-8a99-d47132bc23a1
md"""
Так же в Julia существует возможность создать абстрактный тип, назначение которого похоже на его применение в ООП языках. Абстрактный тип представляет собой надтип для обьединения разных типов, а конкретные типы представляют собой экземпляры данных. 

"Машина это Транспорт" это корректное абстрагирование. Здесь, Машина это конкретный тип, а Транспорт абстрактный. С той же увереностью мы можем сказать "Ракета это Транспорт" и это тоже будет корректной абстракцией. 
"""

# ╔═╡ 47016287-43cf-4509-aad9-c702c767ada8
abstract type PointLike end

# ╔═╡ d533472e-4c50-4fdc-9a1f-533fbb807353
md"""
## Примитивные типы
 Примитивные типы определяются без указания их полей, в отличие от структур (composite types). 

Такие типы полезны, когда вы хотите вручную управлять представлением данных и операциями над данными. Создание примитивного типа не создает конструкторы для этого типа, в отличие от непримитивных пользовательских типов. Добавим функцию-конструктор для этого типа.
"""

# ╔═╡ b5204e51-edc1-4618-94d7-0eb91158ec1d
begin
	primitive type UgaBooga <: Signed 8 end
	UgaBooga(x::Integer) = reinterpret(UgaBooga, Int8(x))
end

# ╔═╡ 3c170135-3cef-4427-8645-0444506e3fff
x::UgaBooga = 42

# ╔═╡ 52386d61-fd19-44e5-bae1-bef6cf781dec
md"""
## Задание 2
Создайте структуру Point с полями x::Float64 и y::Float64. Напишите функцию для расчёта расстояния между двумя точками.
"""

# ╔═╡ 97fdca51-761d-4e35-868d-d9be60bb23a1
md"""
### Задание 3
Создайте абстрактныйтип Vehicle и два конкретных типа, которые от него наследуются: Car и Motorcycle. Каждый из них должен иметь метод для расчёта скорости.
"""

# ╔═╡ 3d8a2b8d-abde-4966-9be6-1215b641e368
md"""
### Задание 4
Напишите функцию sum_even, которая принимает массив целых чисел и возвращает сумму всех чётных элементов
"""

# ╔═╡ 7baf75e4-3906-4970-9705-a53d79852b97
md"""
### Задание 5
Создайте абстрактный тип `Shape`. Создайте подтипы `Circle`, `Rectangle` и `Triangle`, которые наследуются от `Shape`. Напишите функцию, которая проверяет, является ли объект указанным типом.
"""


# ╔═╡ 003a4158-4930-4309-a6a2-0e68718699c1
md"""
### Задание 6
Определите общий метод area для типа `Shape`.
Переопределите метод area для каждого подтипа (`Circle`, `Rectangle`, `Triangle`).
Вызовите метод area для объектов разных типов и убедитесь, что используется правильная реализация
"""

# ╔═╡ Cell order:
# ╠═b8645372-eb92-11ef-19f7-4d4d54d26f36
# ╠═9f0e904b-6fa0-480d-9350-9fc29041e1dc
# ╠═819574e3-abb3-458b-b80d-1946317f4249
# ╠═42074e33-a14c-483a-a079-2629f9f011ea
# ╠═2defc4c7-e1ed-4c35-bb46-4defbff870cb
# ╠═e63dadb6-9241-46bf-b246-3c5293a525f7
# ╠═2556e069-349f-4820-8f43-9f6ef0e5d387
# ╠═b2ea72a2-e878-41b2-a291-1bf20d0eeb84
# ╠═e3bb901a-f24f-4879-9183-a799091b8525
# ╠═d7144a26-3344-4dcd-90df-c1ca02649e6c
# ╠═3824ff40-fba8-4bce-9b30-3509ea91d294
# ╠═baad34dd-4998-4f7a-92cc-7ac3ad3ae01c
# ╠═eb3cddad-146a-4ff0-960a-5e9b8218a608
# ╠═a39532dd-622b-411f-952a-8676f66e6c57
# ╠═29181c1c-3f72-4158-9c0b-e3f6c4689f3c
# ╠═fb4ab5e3-ea8b-4fe5-8ae6-da4584e448f7
# ╠═6c17efde-1d94-4872-a2cc-1e929a474f06
# ╠═586ac0c0-2524-4c55-a766-6441e5eea175
# ╠═096c1705-0a22-47b8-a79a-0ae55386d968
# ╠═2c7c5c2d-27b2-4ed2-8af8-9d6cca3a0136
# ╠═df05f2cd-cc9c-4c12-8924-96941abaabb0
# ╠═94734391-8116-4637-9268-555fbda36d4d
# ╠═a076363d-14df-49ec-9f98-8f75a013f39f
# ╠═8678e9bb-79af-4bc3-8904-db5f7499090e
# ╠═2cd7bf92-6035-43e5-b65f-fb2895278c63
# ╠═57d3396b-eb16-4803-9f97-12258aa0f4d6
# ╠═da8e1b55-a0b6-45b6-ad02-b0084802e950
# ╠═cef20443-7388-40ae-ad88-e8953d78b632
# ╠═52a61d3e-91d3-4187-b284-c385a7adf5a4
# ╠═b9225b3b-b077-4e62-8b94-30047f981ba1
# ╠═1ef3a217-5635-432e-89bf-f76cfabe4819
# ╠═33d99839-753e-4ae1-b6e5-41c13fe8f31f
# ╠═d7ffe6b6-8932-49cc-ac44-edb4fe363b98
# ╠═bb8943d2-903f-4285-ba61-224c3ef40879
# ╠═834528dc-e389-44b7-81ea-307bb461d512
# ╠═61decaf6-04c0-4032-ae11-c6446078cb7b
# ╠═e58a5b40-ed92-40ca-a283-f305a5488b5a
# ╠═a584722e-536f-4802-af99-e912001f7c7f
# ╠═fd547053-dfc7-45d2-b5f7-89d52097abef
# ╠═6710d5b4-28fa-4f62-be52-b44d62b22f47
# ╠═acc8ddc5-d81a-4071-bdd9-19eb154e6850
# ╠═b96510f0-a982-4914-8119-d853df64471a
# ╠═1e63763c-be01-4a4b-8b4d-6ad9296acddf
# ╠═93ea4e16-e120-455a-ba1f-0c8bbe49e147
# ╠═51d3ca4e-ab62-458e-ba8a-7c3948a05c5d
# ╠═bc9f839c-1442-451b-97eb-57b00fe02ba1
# ╠═ee873619-9d91-4dba-95e9-4f1dee8383cd
# ╠═fc401300-2ca8-43c5-8a0b-e01dd2a4d20e
# ╠═ea1e43d1-910a-4cd1-98d3-8ec1b19af7a3
# ╠═038aa323-6c5b-4a37-beab-ead9c8779566
# ╠═fab65f67-a386-40b9-8a99-d47132bc23a1
# ╠═47016287-43cf-4509-aad9-c702c767ada8
# ╠═d533472e-4c50-4fdc-9a1f-533fbb807353
# ╠═b5204e51-edc1-4618-94d7-0eb91158ec1d
# ╠═3c170135-3cef-4427-8645-0444506e3fff
# ╠═67b06359-fb3e-4751-b638-b43f4bd32d57
# ╠═573849d7-7ba7-4209-8806-9ba6dd4660b2
# ╠═52386d61-fd19-44e5-bae1-bef6cf781dec
# ╠═97fdca51-761d-4e35-868d-d9be60bb23a1
# ╠═3d8a2b8d-abde-4966-9be6-1215b641e368
# ╠═7baf75e4-3906-4970-9705-a53d79852b97
# ╠═003a4158-4930-4309-a6a2-0e68718699c1
