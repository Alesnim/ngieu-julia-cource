### A Pluto.jl notebook ###
# v0.20.4

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ a1608555-667a-4af7-a547-b941a52f581f
using PlutoUI
# Используем интерактивный виджет для удобства ввода

# ╔═╡ 344e7a29-4d92-4a62-9977-93f03def4ed5
md"""
# Циклы 
В Julia присутствуют как декларации цикла while, так и декларации цикла for 
"""

# ╔═╡ 5c34e7bb-6c47-4a9e-bff8-8437d22487cd
begin
	n = 0
	while n < 2 
		println(n)
		n+= 1
	end
end

# ╔═╡ 9c62b614-b2a9-4e42-921e-bacfee6497eb
begin
	myfriends = ["Тэд", "Робин", "Барни", "Лилли", "Маршалл"]
	
	i = 1
	while i <= length(myfriends) # length это получение длины массива
	    friend = myfriends[i]
	    println("Привет $friend, как дела?")
	    i += 1
	end
end

# ╔═╡ 0a2a9926-a0b6-4a71-befb-c96f79fb06b1
md"""
Для повышения удобства работы с перечисляемыми структурами, в Julia используется цикл for

"""

# ╔═╡ d181d898-d29a-4ec9-b93f-423e3644bda6
begin
	for n in 1:10
    	println(n)
	end
end

# ╔═╡ 297c939c-18a2-42ec-825c-31d918b75726
begin
	for friend in myfriends
	    println("Привет $friend, как дела?")
	end
end

# ╔═╡ 42a1ad53-ec2e-4f6e-ae42-df360d11c91e
md"""
Но использование for в полной мере раскрывается на многомерных массивах и их индексах. 

Для примера создадим таблицу, значения в которой будут вычисляться как суммы индексов ячейки таблицы

Сначала зададим инициализируем такой массив
"""

# ╔═╡ 2fe8d018-f4ed-4bb8-bb03-9f860869291f
begin
m, nn = 5, 5
A = fill(0, (m, nn))
end

# ╔═╡ f8e78475-10d5-4244-bde8-cc8ad418e15b
md"""
## Задание 1
Вызовите и прочтите справку по функции `fill`
"""

# ╔═╡ 37025c4b-8e43-4b3f-8ae4-5942789fa2be
md"""
Реализуем алгоритм заполнения без применения синтаксического сахара, предоставляемого Julia. Два цикла, в каждом из которых своя переменная-итератор
"""

# ╔═╡ 57194493-0648-4756-b51d-d359fd252238
begin
for j in 1:nn
    for i in 1:m
        A[i, j] = i + j
    end
end
A
end

# ╔═╡ 454ec968-0853-487e-b33c-124191b0c863
md"""
Установим все значения в массиве снова в 0
"""

# ╔═╡ d3201e61-f92f-4b61-a01d-5640bddba005
A .= 0

# ╔═╡ 78d2c756-b6f0-44ba-a451-c24cfd1c72b1
md"""
Теперь используем идеоматичный (в соответствии со стилем и идеями языка) вариант реализации
"""

# ╔═╡ de7cc223-62be-4f69-a066-bea646e53e16
begin
	for j in 1:nn, i in 1:m
	    A[i, j] = i + j
	end
A
end

# ╔═╡ 9dc4ef38-bd5a-4615-b812-a8a4274bcc93
md"""
Но и такой вариант сделать еще более компактным, используя списковые выражения (аналог можно найти в Pyhon, С#, Scala)
"""

# ╔═╡ 389cf5ef-225c-4d71-9645-61a79181ae3d
C = [i + j for i in 1:m, j in 1:nn]

# ╔═╡ cf0fcb51-d394-4e1a-9f9e-114593b7540b
md"""
# Условные конструкции
Как и во многих других языках программирования, в Julia для управления ветвлением используются ключевые слова `if`, `else`. Реализуем классическую задачу, которая может быть вам уже знакома -- FizzBuzz. 

По условиям задачи мы принимаем число `n` на вход программы. Если число делится на 3, тогда мы печатаем Fizz, если число делится на 5 пишет Buzz. Если число делится и на 3, и на 5, тогда пишем FizzBuzz. Иначе пишем само число. 
"""

# ╔═╡ 4f375f83-741e-4c11-9206-567f0f36f360
@bind N NumberField(0:100, default=3)

# ╔═╡ 65112165-b9de-41a1-a84d-ad26b60f56ef
begin
	if (N % 3 == 0) && (N % 5 == 0) # `&&` значит "И"
	    println("FizzBuzz")
	elseif N % 3 == 0
	    println("Fizz")
	elseif N % 5 == 0
	    println("Buzz")
	else
	    println(N)
	end
end

# ╔═╡ bcdab88c-8b6e-48f2-ac1c-de04eb8bf20d
md"""
Для сокращения записи простых условий можно использовать тернарный оператор ветвления
"""

# ╔═╡ a9494682-60a6-45d5-9380-b4a90ab64a0a
@bind x NumberField(0:100, default=3)

# ╔═╡ 5cc75338-ab9a-4458-93c4-f884fe828a90
@bind y NumberField(0:100, default=1)

# ╔═╡ 203f9369-00a1-4140-8232-e00616a558fc
(x > y) ? x : y

# ╔═╡ ec52c136-d363-44f7-b394-93d7115c4f74
md"""
Это эквивалентно следующему коду:
```julia
if x > y
    x
else
    y
end
```
"""

# ╔═╡ a5bea49b-687b-49c5-8713-2ffa5ba81a13


# ╔═╡ 428c644c-4835-404d-99b3-a84b4236e873
md"""
# Задания 
## Задание 2 
Реализуйте цикл от 1 до 20 и напечатайте их квадраты. Реализуйте это как при помощи while и for, так и при помощи списковых выражений

## Задание 3
Создайте словарь `squares`, где ключами будут числа от 1 до 20, а значениями их квадраты. 
Например, следующий код должен корректно исполнится 
```julia
squares[10] == 100
```
## Задание 4
Напишите условие, которое проверяет четность числа от -100 до 1000. Ввод числа осуществляется при помощи интерактивного виджета
### Задание 5
Перепишите задание 4 с использованием тернарного оператора ветвления
### Задание 6
Найдите и выведите все числа Армстронга в диапазоне от 100 до 150. Число Армстронга -- это число, равное сумме кубов своих цифр.
Пример: 153 является числом Армстронга, потому что: $$1^3 + 5^3 + 3^3 = 153$$
## Задание 7
Напишите программу, которая выводит столбец таблицы умножения, например, для 6 в формате:

первый множитель * второй множитель = результат умножения  
## Задание 8
Напишите алгоритм, который принимает на вход массив и создает новый массив, в котором удалены все повторяющиеся значения
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.61"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.3"
manifest_format = "2.0"
project_hash = "6d1b77f27e79835fc27b2d7e99ab8fcaf37aa976"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

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
git-tree-sha1 = "1833212fd6f580c20d4291da9c1b4e8a655b128e"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.0.0"

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

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

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
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

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
# ╠═344e7a29-4d92-4a62-9977-93f03def4ed5
# ╠═5c34e7bb-6c47-4a9e-bff8-8437d22487cd
# ╠═9c62b614-b2a9-4e42-921e-bacfee6497eb
# ╠═0a2a9926-a0b6-4a71-befb-c96f79fb06b1
# ╠═d181d898-d29a-4ec9-b93f-423e3644bda6
# ╠═297c939c-18a2-42ec-825c-31d918b75726
# ╠═42a1ad53-ec2e-4f6e-ae42-df360d11c91e
# ╠═2fe8d018-f4ed-4bb8-bb03-9f860869291f
# ╠═f8e78475-10d5-4244-bde8-cc8ad418e15b
# ╠═37025c4b-8e43-4b3f-8ae4-5942789fa2be
# ╠═57194493-0648-4756-b51d-d359fd252238
# ╠═454ec968-0853-487e-b33c-124191b0c863
# ╠═d3201e61-f92f-4b61-a01d-5640bddba005
# ╠═78d2c756-b6f0-44ba-a451-c24cfd1c72b1
# ╠═de7cc223-62be-4f69-a066-bea646e53e16
# ╠═9dc4ef38-bd5a-4615-b812-a8a4274bcc93
# ╠═389cf5ef-225c-4d71-9645-61a79181ae3d
# ╠═cf0fcb51-d394-4e1a-9f9e-114593b7540b
# ╠═a1608555-667a-4af7-a547-b941a52f581f
# ╠═4f375f83-741e-4c11-9206-567f0f36f360
# ╠═65112165-b9de-41a1-a84d-ad26b60f56ef
# ╠═bcdab88c-8b6e-48f2-ac1c-de04eb8bf20d
# ╠═a9494682-60a6-45d5-9380-b4a90ab64a0a
# ╠═5cc75338-ab9a-4458-93c4-f884fe828a90
# ╠═203f9369-00a1-4140-8232-e00616a558fc
# ╠═ec52c136-d363-44f7-b394-93d7115c4f74
# ╠═a5bea49b-687b-49c5-8713-2ffa5ba81a13
# ╠═428c644c-4835-404d-99b3-a84b4236e873
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
