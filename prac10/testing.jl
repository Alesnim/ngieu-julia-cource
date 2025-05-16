### A Pluto.jl notebook ###
# v0.20.8

using Markdown
using InteractiveUtils

# ╔═╡ 81c932e4-052e-43b2-b777-dd996e7b3e04
using Test, Spec, Aqua, PlutoUI

# ╔═╡ b9f2af34-e23d-4aa5-b092-bdf6f7b9a227
TableOfContents()

# ╔═╡ 3b6b4650-1da9-11f0-13dd-3db707713735
md"""
# Практическя работа
"""

# ╔═╡ d6f8c430-15fe-4bbc-9ad5-54fe3128b261
md"""
# Исключения

> Исключения (exceptions) — механизм обработки ошибок и нештатных ситуаций в процессе выполнения программы.

Все исключения в Julia наследуются от абстрактного типа Exception.

Встроенные исключения:
- `ArgumentError`: Некорректные аргументы функции.
- `DomainError`: Значение вне области определения функции (например, sqrt(-1)).
- `BoundsError`: Выход за границы массива.
- `DivideByZeroError`: Деление на ноль.
- `TypeError`: Несоответствие типов.
- `UndefVarError`: Попытка использования необъявленной переменной.
"""

# ╔═╡ 4170ad12-d94b-4354-894e-f32a81366c3b
try  
    sqrt(-1)  
catch e  
    println("Ошибка: ", e)  
end  
# Вывод: Ошибка: DomainError(-1.0, "sqrt will only return a complex result if called with a complex argument.")  

# ╔═╡ f1dd03d1-7b9a-4cfe-a6da-81538acd3212
md"""
Для явного вызова исключений используется функция `throw()`
"""

# ╔═╡ 810a10cd-5703-447f-b4c2-8875d3a26db6
function divide(a, b)  
    b == 0 && throw(DivideByZeroError())  
    a / b  
end  

# ╔═╡ 0c60aa45-0216-4d06-adde-b98728c32ca3
try 
	divide(0, 0)
catch DivideError 
	println("CATCH")
end

# ╔═╡ 0953ef15-f440-4809-b5e4-b56d512c9e25
md"""
В случае необходимости, возможно определение пользовательских исключений путем наследования
"""

# ╔═╡ 27b1ee9a-d729-491f-8906-430caed21f47
struct NegativeNumberError <: Exception  
    message::String  
end  

# ╔═╡ 108ddbb5-e5a9-48d0-bc81-b00dcb348384
function check_positive(x)  
    x < 0 && throw(NegativeNumberError("Число должно быть положительным"))  
    sqrt(x)  
end  

# ╔═╡ 39bce5b9-9757-4116-9d08-eec4065bec39
try  
    check_positive(-5)  
catch e  
    println("Ошибка: ", e.message)  
end  

# ╔═╡ bd544bf1-fd16-4bf0-b17d-f7a8183adf27
md"""
При работе со сложной системой исключения могут передаваться по сложной цепочке вызовов и выбрасываться повторно. Для работы с исключениями в Julia есть несколько дополнительных функций.

- rethrow(): Повторно вызывает текущее исключение.
- backtrace(): Возвращает трассировку стека для отладки.
- Base.throw_boundserror(): Специализированные функции для генерации встроенных исключений.
"""

# ╔═╡ f1360ef9-6155-410c-abd5-4936c709afc2
md"""
Если необходимо обработать несколько исключений, используются цепочки условий 

```julia
try  
    # Код с потенциальными ошибками  
catch e  
    if e isa DomainError  
        println("Ошибка области определения")  
    elseif e isa ArgumentError  
        println("Некорректные аргументы")  
    else  
        println("Неизвестная ошибка: ", e)  
    end  
end  
```
"""

# ╔═╡ 1dff0a42-f30c-440d-b21c-df88047a1f7d
md"""
# Тестирование 

> Тестирование — систематический процесс верификации корректности программного кода

Тестирование позволяет: 
- Обнаружить ошибки: выявление логических, синтаксических и семантических дефектов.
- Обеспечить надежность: подтверждение соответствия кода заявленным требованиям и спецификациям.
- Облегчение рефакторинга: гарантия сохранения функциональности при модификациях.
- Документировать поведение: тесты как спецификация ожидаемых результатов.
- Предотвратить регрессии: защита от повторного возникновения ранее исправленных ошибок.

Динамическая типизация и продвинутые возможности языка (мета-программирование) естественным образом повышают шанс ошибки, поэтому программы на динамических языках требуют еще более тщательного тестирования. 

Специфика назначения языка, научные вычисления, также требуют наличия проверки корректности этих вычислений, для чего и пишутся тесты. 

В зависимости от назначения и обьекта тестирования можно вывести несколько типов тестов:
- Модульное тестирование 

  Определение: проверка отдельных компонентов (функций, методов, модулей) в изоляции.
  
  Цели:
  - Проверка атомарных операций.
  - Тестирование всех ветвлений кода (if-else, циклов).

- Интеграционное тестирование (Integration Testing)

  Определение: проверка взаимодействия нескольких модулей или систем.

  Примеры:

  - Корректность передачи данных между функциями.

  - Работа с внешними API или базами данных.
- Property-Based тестирование

  Определение: проверка соблюдения формальных свойств (инвариантов) для произвольных входных данных.

  Примеры:
  - Коммутативность операций: a + b = b + a.
  - Идемпотентность: sort(sort(arr)) == sort(arr).


При включении тестирования в процесс разработки, для повышения качества кода, он может быть организован согласно специальной методологии:

- Test-Driven Development (TDD)

  Принципы:
  - Написание тестов до реализации функциональности.
  - Итеративная разработка: «красный → зеленый → рефакторинг».

- Контрактное программирование 

  Принципы: 
  - Разработка пред- и пост- условий для проверки данных 
"""

# ╔═╡ 4f435db9-a31d-406e-a314-88950f1e0ad6
md"""
## Тестирование в Julia 


### Пакет Test
Базовым пакетом для тестирования является `Test` предоставляющий простой интерфейс для тестирования.

Макрос `@test` позволяет проверить утверждение на истинность. Макрос `@test_broken` позволяет проверить не истинность утверждения. Под утверждением понимается выражение возвращяющее `true` или `false`
"""

# ╔═╡ 9e6afa31-5194-4421-a6a9-1a647bdd4f32
@test 2 + 2 == 4

# ╔═╡ f445e003-727a-443d-8ceb-a38560f391de
@test_broken 2 + 2 == 5

# ╔═╡ adf6c2a4-425b-460e-a3fc-c388a6fef8bf
md"""
Если необходимо проверить несколько утверждений сразу, тогда можно собрать тесты в наборы и запускать их комплектом при помощи макроса `@testset`
"""

# ╔═╡ 2f588261-e417-4f0e-8e7f-adab61a522e0
@testset "Пример набора тестов" begin 
	@test 2 + 2 == 4
	@test 2 - 2 == 0
	@test_broken 2 - 2 == 1
end 

# ╔═╡ 97cfa6e9-077f-4130-9abb-7a2900611a75
md"""
Реализуем простой модуль и проведем его тестирование. 
"""

# ╔═╡ e5b69f6c-8df9-4a6d-86de-a96e31b95bc6
module MyMathUtils

export add, subtract, is_even, factorial

add(a::Number, b::Number) = a + b

subtract(a::Number, b::Number) = a - b

is_even(n::Int) = n % 2 == 0

function factorial(n::Int)
    n >= 0 || throw(ArgumentError("n must be non-negative"))
    n == 0 ? 1 : n * factorial(n - 1)
end

end

# ╔═╡ 0c7251f3-0aa2-4f6c-8dd5-e42e68466d70
@testset "MathUtils: Тестирование базовых операций" begin

    # --- Тесты для функции add ---
    @testset "add(a, b)" begin
        @test MyMathUtils.add(2, 3) == 5
        @test MyMathUtils.add(-1, 5) == 4
        @test MyMathUtils.add(0, 0) == 0
        @test MyMathUtils.add(1.5, 2.5) ≈ 4.0  # Проверка приближённого равенства
    end

    # --- Тесты для функции subtract ---
    @testset "subtract(a, b)" begin
        @test MyMathUtils.subtract(5, 3) == 2
        @test MyMathUtils.subtract(0, 5) == -5
        @test MyMathUtils.subtract(3.5, 1.2) ≈ 2.3
    end

    # --- Тесты для функции is_even ---
    @testset "is_even(n)" begin
        @test MyMathUtils.is_even(4) == true
        @test MyMathUtils.is_even(7) == false
    end

    # --- Тесты для функции factorial ---
    @testset "factorial(n)" begin
        @test MyMathUtils.factorial(0) == 1
        @test MyMathUtils.factorial(5) == 120
    end

end

# ╔═╡ 2b6d054b-17b9-4814-8ab8-aecb36a0d38c
md"""
Мощным приемом тестирования, для исключения граничных случаев, является параметрическое тестирование. В `Test` для этого используются циклы тестов
"""

# ╔═╡ 9491bf52-1bab-4e79-800d-3699bb2bafa6

@testset "Пример параметрического теста" begin
	for (a, b, expected) in [(2, 3, 5), (-1, 1, 0)]
	    @test MyMathUtils.add(a, b) == expected
	end
end

# ╔═╡ 6e97a214-0922-471f-81ec-f194104fe667
md"""
### Пакет Spec


Более сложным подходом к проверке корректности поведения кода является BDD (проектирование от поведения) в котором обьявляются контракты на поведение исходного кода на естественном языке и описываются тестовые случаи, которые должны проверить их соблюдение. Реализацию такого подхода облегчает пакет Spec. Спроектируем модуль для проверки. 
"""

# ╔═╡ 6827d680-be01-42cd-978c-f78067afa1e9
module EmailTools

export validate_email, get_domain, maybe_get_email

# Проверка валидности email (упрощённая версия)
function validate_email(email::String)
    occursin(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$", email)
end

# Извлечение домена из email
function get_domain(email::String)
    parts = split(email, '@')
    length(parts) == 2 || throw(ArgumentError("Invalid email format"))
    parts[2]
end

# Обработка опциональных email-адресов
function maybe_get_email(data::Union{String,Nothing})
    isnothing(data) ? "default@example.com" : data
end

end

# ╔═╡ ba00ad80-1f17-44a2-8be3-fc4a464197a0
md"""
Описывая спецификацию, определяется следующая структура "Спецификация -> Описание функции -> Интерфейс -> Ожидается" 
"""

# ╔═╡ 3c003cab-38ab-4b52-84d5-bb4b0a09bfa6

@spec "EmailTools" begin
    
    @describe "validate_email()" begin
        @it "должна возвращать true для валидных email-адресов" begin
            @expect EmailTools.validate_email("user@example.com") == true
            @expect EmailTools.validate_email("john.doe+123@sub.domain.org") == true
        end

        @it "должна возвращать false для невалидных email-адресов" begin
            @expect EmailTools.validate_email("invalid@.com") == false
            @expect EmailTools.validate_email("no_at_symbol") == false
            @expect EmailTools.validate_email("space in@name.com") == false
        end
    end

    @describe "get_domain()" begin
        @it "должна корректно извлекать домен" begin
            @expect EmailTools.get_domain("admin@google.com") == "google.com"
        end

        @it "должна выбрасывать ArgumentError для некорректных адресов" begin
            @expect_throws ArgumentError EmailTools.get_domain("not_an_email")
        end
    end

    @describe "maybe_get_email()" begin
        @it "должна возвращать дефолтный адрес для Nothing" begin
            @expect EmailTools.maybe_get_email(nothing) == "default@example.com"
        end

        @it "должна возвращать исходное значение для строки" begin
            @expect EmailTools.maybe_get_email("custom@mail.ru") == "custom@mail.ru"
        end
    end

end

# ╔═╡ 4b7a6fc7-f868-46c8-99eb-4739a1fa8658
md"""
# Задания
"""

# ╔═╡ 212b0c4e-9083-413f-9e8b-9030d5072ae4
md"""
## Задание 1

Реализуйте функцию normalize_name(name::String), которая:
- Удаляет начальные и конечные пробелы.
- Заменяет множественные пробелы внутри строки на один.
- Переводит первый символ каждого слова в верхний регистр, остальные — в нижний.

После реализации проведите тестирование 
```
@testset "normalize_name" begin  
    @test normalize_name("  jOhn   dOe ") == "John Doe"  
    @test normalize_name("aBc  XYZ") == "Abc Xyz"  
    @test normalize_name("") == ""  
    @test normalize_name("   ") == ""  
    @test normalize_name("123 test") == "123 Test"  
end  
```
"""

# ╔═╡ f2679700-a30e-4599-a95b-d2ebc5b94f98
md"""
## Задание 2

Создайте функцию safe_division(a::Number, b::Number), которая:
- Возвращает a / b, если b ≠ 0.
- Кидает DomainError, если b = 0.
- Кидает ArgumentError, если a или b не являются числами.


После реализации напишите тесты и проведите тестирование
"""

# ╔═╡ b0935b82-386f-4e32-8d67-1bd7b3ed69d7
md"""
## Задание 3
Создайте структуру Queue, которая хранит элементы в векторе.

Реализуйте методы:

- enqueue!(q::Queue, item): Добавляет элемент в конец очереди.
- dequeue!(q::Queue): Удаляет и возвращает первый элемент (кидает BoundsError, если очередь пуста).
- is_empty(q::Queue): Проверяет, пуста ли очередь.


После реализации проведите тестирование 

```julia 
@testset "Queue" begin  
    q = Queue()  
    @test is_empty(q) == true  
    enqueue!(q, 10)  
    enqueue!(q, 20)  
    @test dequeue!(q) == 10  
    @test dequeue!(q) == 20  
    @test_throws BoundsError dequeue!(q)  
    @test is_empty(q) == true  
end  
```
"""

# ╔═╡ 3db3b193-4111-4458-b0b7-bcf424bb86de
md"""
## Задание 4

Дана некорректная функция count_vowels(s::String), которая должна возвращать количество гласных букв (a, e, i, o, u) в строке без учета регистра. 

Исправьте функцию и проведите тестирование 
```julia
@testset "count_vowels" begin  
    @test count_vowels("Hello World") == 3  # 'e', 'o', 'o'  
    @test count_vowels("AEiou") == 5  
    @test count_vowels("xyz") == 0  
    @test count_vowels("") == 0  
end  
```
"""

# ╔═╡ 3f607fbf-92a6-4c91-b0b8-3b82433fab17
function count_vowels(s)  
    vowels = ['a', 'e', 'i', 'o', 'u']  
    count = 0  
    for char in s  
        if lowercase(char) in vowels  
            count += 1  
        end  
    end  
    return count  
end  

# ╔═╡ 7cb56da9-6624-457d-b3bc-28f701446f19


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Aqua = "4c88cf16-eb10-579e-8560-4a9242c79595"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Spec = "b8ccf107-3a88-5e0f-823b-b838c6a0f327"
Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[compat]
Aqua = "~0.8.11"
PlutoUI = "~0.7.61"
Spec = "~0.3.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.4"
manifest_format = "2.0"
project_hash = "873f036a91a958122c83a014575d4f5b89c84df2"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.Aqua]]
deps = ["Compat", "Pkg", "Test"]
git-tree-sha1 = "500941611ff835a025f484f55836f6feea61720a"
uuid = "4c88cf16-eb10-579e-8560-4a9242c79595"
version = "0.8.11"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.Cassette]]
git-tree-sha1 = "f8764df8d9d2aec2812f009a1ac39e46c33354b8"
uuid = "7057c7e9-c182-5462-911a-8362d720325c"
version = "0.3.14"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MLStyle]]
git-tree-sha1 = "bc38dff0548128765760c79eb7388a4b37fae2c8"
uuid = "d8e11817-5142-5d16-987a-aa16d5891078"
version = "0.4.17"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OrderedCollections]]
git-tree-sha1 = "cc4054e898b852042d7b503313f7ad03de99c3dd"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.0"

[[deps.Parameters]]
deps = ["OrderedCollections", "UnPack"]
git-tree-sha1 = "34c0e9ad262e5f7fc75b10a9952ca7692cfc5fbe"
uuid = "d96e819e-fc66-5662-9728-84c9c7592b0a"
version = "0.12.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "44f6c1f38f77cafef9450ff93946c53bd9ca16ff"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"

    [deps.Pkg.extensions]
    REPLExt = "REPL"

    [deps.Pkg.weakdeps]
    REPL = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "7e71a55b87222942f0f9337be62e26b1f103d3e4"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.61"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Spec]]
deps = ["Cassette", "MLStyle", "Parameters", "Pkg", "Random", "Test"]
git-tree-sha1 = "8747d1a0032266bc7e9b795f85062dfa680311cf"
uuid = "b8ccf107-3a88-5e0f-823b-b838c6a0f327"
version = "0.3.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

[[deps.URIs]]
git-tree-sha1 = "cbbebadbcc76c5ca1cc4b4f3b0614b3e603b5000"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.UnPack]]
git-tree-sha1 = "387c1f73762231e86e0c9c5443ce3b4a0a9a0c2b"
uuid = "3a884ed6-31ef-47d7-9d2a-63182c4928ed"
version = "1.0.2"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╠═81c932e4-052e-43b2-b777-dd996e7b3e04
# ╠═b9f2af34-e23d-4aa5-b092-bdf6f7b9a227
# ╟─3b6b4650-1da9-11f0-13dd-3db707713735
# ╟─d6f8c430-15fe-4bbc-9ad5-54fe3128b261
# ╠═4170ad12-d94b-4354-894e-f32a81366c3b
# ╟─f1dd03d1-7b9a-4cfe-a6da-81538acd3212
# ╠═810a10cd-5703-447f-b4c2-8875d3a26db6
# ╠═0c60aa45-0216-4d06-adde-b98728c32ca3
# ╟─0953ef15-f440-4809-b5e4-b56d512c9e25
# ╠═27b1ee9a-d729-491f-8906-430caed21f47
# ╠═108ddbb5-e5a9-48d0-bc81-b00dcb348384
# ╠═39bce5b9-9757-4116-9d08-eec4065bec39
# ╟─bd544bf1-fd16-4bf0-b17d-f7a8183adf27
# ╠═f1360ef9-6155-410c-abd5-4936c709afc2
# ╟─1dff0a42-f30c-440d-b21c-df88047a1f7d
# ╟─4f435db9-a31d-406e-a314-88950f1e0ad6
# ╠═9e6afa31-5194-4421-a6a9-1a647bdd4f32
# ╠═f445e003-727a-443d-8ceb-a38560f391de
# ╟─adf6c2a4-425b-460e-a3fc-c388a6fef8bf
# ╠═2f588261-e417-4f0e-8e7f-adab61a522e0
# ╟─97cfa6e9-077f-4130-9abb-7a2900611a75
# ╠═e5b69f6c-8df9-4a6d-86de-a96e31b95bc6
# ╠═0c7251f3-0aa2-4f6c-8dd5-e42e68466d70
# ╟─2b6d054b-17b9-4814-8ab8-aecb36a0d38c
# ╠═9491bf52-1bab-4e79-800d-3699bb2bafa6
# ╟─6e97a214-0922-471f-81ec-f194104fe667
# ╠═6827d680-be01-42cd-978c-f78067afa1e9
# ╟─ba00ad80-1f17-44a2-8be3-fc4a464197a0
# ╠═3c003cab-38ab-4b52-84d5-bb4b0a09bfa6
# ╟─4b7a6fc7-f868-46c8-99eb-4739a1fa8658
# ╟─212b0c4e-9083-413f-9e8b-9030d5072ae4
# ╟─f2679700-a30e-4599-a95b-d2ebc5b94f98
# ╟─b0935b82-386f-4e32-8d67-1bd7b3ed69d7
# ╟─3db3b193-4111-4458-b0b7-bcf424bb86de
# ╠═3f607fbf-92a6-4c91-b0b8-3b82433fab17
# ╠═7cb56da9-6624-457d-b3bc-28f701446f19
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
