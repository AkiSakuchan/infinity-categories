#import "book-style.typ": *
#import "@preview/theorion:0.3.3": *
#import "@preview/commute:0.3.0": node, arr, commutative-diagram
#import cosmos.rainbow: *


#show: show-theorion

#show: rest => book(title: [$infinity$-范畴讲义], 
authors: "Aki Sakuchan", 
bib-file: "references.bib",
rest)



= 公理化定义
本章的目标是不给出无穷范畴的分析式的定义，而是通过公理化的办法给出综合式的定义。也就是把无穷范畴视为元概念，讨论它应该满足的公理。
就像你不能不能在欧式几何中分析地定义什么是"点，线，面"，
但是你可以给出它们应该满足的公理。而通过实数理论，就可以给出点的分析式定义，也就是 $RR^3$ 中的元素。
而线可以定义为下列实系数方程组的解空间，这里方程组系数线性无关：
#nonum-equation[$
    cases(a_1 x + b_1 y + c_1 z &= d_1,
                    a_2 x + b_2 y + c_2 z &= d_2)
$]
面可以定义为单个一次方程的解空间，圆等几何对象也有类似定义。从这个例子可以看出，所谓分析的观点更关注对象的具体结构，或者说是它的内涵，
而综合的观点则关注对象应该满足的性质，或者说它和其他对象的关系。

本章主要内容来自@cnossen2025[Chapter 1] 在后面几章会给出满足这个定义的一些模型，比如*拟范畴*，*单纯充实范畴*，*拓扑充实范畴*。

在一般的数学理论中，两个数学对象我们仅仅是讨论它们相等还是不相等。但实际上相等亦有程度上的区别，比如说相等的两个集合，往往因为上面赋予不同的数学结构而被视为不同的数学对象。
有时候两个数学对象，在某个层面上相等，然而在另一个层面就被认为不相等了，比如在代数学中，只要两个向量空间的维数相同那么就认为它们同构，然而在泛函分析中仅仅是维数相同还不够。
反过来，有时候也认为相同的东西在更底层不相同，比如代数拓扑中同伦的空间不一定同胚。因此*我们不但要指出两个对象是否相等，还要给出它们如何相等*，这允许我们讨论两个数学对象之间相等的程度。

== 范畴，函子和自然同构
本文不会用一阶语言来给出范畴公理，那实在是过于繁琐了。
#axiom(title: "A.1")[
    #enum(numbering: "(1)")[
        有一些数学对象，称为 *$(infinity,1)$-范畴*， 经常简称为*无穷范畴*, 记为 $cal(C), cal(D), cal(E) dots$ 等。
        ][
            给定两个无穷范畴 $cal(C)$ 和 $cal(D)$，它们之间可以有*函子*，也称为 *$1$-态射* $f : cal(C) -> cal(D)$。
            每个 $cal(C)$ 都有到它自身的恒等函子 $id : cal(C) -> cal(C)$。
            给定两个函子 $f : cal(C) -> cal(D)$ 和 $g : cal(D) -> cal(E)$，则有（横向）复合函子 $g compose f : cal(C) -> cal(E)$ 也是一个函子。
        ][
            给定两个函子 $f,f' : cal(C) -> cal(D)$, 它们之间可以有*自然变换*， 也称为 *$2$-态射* $alpha : f -> f'$。
            每个函子 $f$ 都有单位自然变换 $id_f : f -> f$。
            给定两个自然变换 $alpha : f -> f'$ 和 $beta : f' -> f''$, 则有（纵向）复合 $beta compose alpha : f -> f''$。
        ][
            给定两个自然变换 $alpha,alpha' : f -> f'$，它们之间也可以有 *$3$-态射* $alpha -> alpha'$。
        ][
            上面过程可以迭代下去，两个 $(m-1)$-态射之间可以有 $m$-态射，每个 $(m-1)$-态射有到它自身的单位 $m$-态射，$m-1$-态射之间可以有复合，称为纵向复合，
            此时，三个 $m-1$-态射之间的 $m$-态射的复合称为纵向复合。
        ][
            对每个 $m > 1$, $m$-态射在同伦意义下可逆，称为 $m$-同构（这个逆的含义下面解释）。
        ]
]
这里把最后一条改为 $m > n$ 将得到 $(infinity, n)$-范畴，但是这种范畴我们将通过 $(infinity,n-1)$-范畴充实态射空间递归得到。
而如果改为 $m > 0$ 将得到 $infinity$-群胚，但是这种范畴我们将定义为 *Kan 复形*。

上述给出 $(m-1)$-态射之间如果有 $m$-同构，则认为它们相等，而按照直觉，这些复合应该满足结合律和单位律，然而这里的相等实际上是两个 $(m-1)$-态射之间的相等，自然应该要由 $m$-同构给出：
#axiom(title:"A.2")[
    $(m-1)$-态射的复合在 $m$-同构意义上满足我们希望的性质，也就是对于$(m-1)$-态射 $f: cal(C) -> cal(D), g: cal(D) -> cal(E)$ 和 $h: cal(E) -> cal(F)$，存在 $m$-同构使得有
    / 结合律: $alpha_(f,g,h): (h compose g) compose f tilde.equiv h compose (g compose f)$。
    / 单位律: $lambda_f : id_cal(D) compose f tilde.equiv f$ 和 $rho_f : f compose id_cal(C) tilde.equiv f$。
    / 逆律: 对每个 $m > 1$ 态射 $alpha : f -> f'$, 存在逆 $m$-态射 $alpha^(-1): f' -> f$ 和 $(m+1)$-同构 $lambda : alpha^(-1) compose alpha tilde.equiv id_f$ 以及 $rho: alpha compose alpha^(-1) tilde.equiv id_(f')$
]<axiom:结合单位逆>

#axiom(title: "A.3")[
    设有两个函子 $f,f':cal(C) -> cal(D)$ 之间的自然同构 $alpha: f tilde.equiv f'$ 和 $g,g':cal(D) -> cal(E)$ 的之间的自然同构 $beta: g tilde.equiv g'$,
    那么有自然同构 $beta * alpha : g compose f tilde.equiv g' compose f'$, 称为自然变换的水平复合，水平复合也要满足单位律和结合律。
]<axiom:水平复合>
这个公理当然也可以推广到 $m$-态射当中，但我们省略。

#definition(title: "交换方块")[
    函子的*交换方块*是形如
    #align(center)[#commutative-diagram(
        node((0,0),$cal(C)$),
        node((0,1),$cal(D)$),
        node((1,0),$cal(C')$),
        node((1,1),$cal(D')$),
        arr((0,0),(0,1),$f$),
        arr((0,0),(1,0),$g$,label-pos:right),
        arr((0,1),(1,1),$h$),
        arr((1,0),(1,1),$f'$,label-pos: right)
    )]
    这里 $f,g,h,f'$ 是函子，并且有自然同构 $alpha : h compose f tilde.equiv f' compose g$. 而函子的*交换三角*指的是
    #align(center, commutative-diagram(
        node((1, 0), $C$),
        node((0, 1), $D$),
        node((1, 2), $E$),
        arr((1, 0), (0, 1), $f$),
        arr((0, 1), (1, 2), $g$),
        arr((1, 0), (1, 2), $h$, label-pos: right),
    ))
    并且有自然同构 $alpha : h tilde.equiv g compose f$. 类似地，也可以定义 $m$-态射的交换方块和交换三角。
]

现在我们可以考虑范畴等价的问题了，范畴同构是范畴等价的一种，但是这是很强的一种相等，而按照上面的观点，相等的程度也是要给出的，因此有：
#definition[
    函子 $f: cal(C) -> cal(D)$ 称为*范畴等价(equivalence)*，
    指的是存在另一个函子 $g: cal(D) -> cal(C)$ 和自然同构 $g f tilde.equiv id_cal(C)$ 和 $f g tilde.equiv id_cal(D)$。
    此时我们说 $g$ 是 $f$ 的一个逆。
]

#lemma[
    函子 $f$ 是范畴等价当且仅当它同时有截面（函子 $g$ 使得 $f g tilde.equiv id_cal(D)$）和缩回（函子 $g$ 使得 $h f tilde.equiv id_cal(C)$, 
    并且在这种情况下 $g tilde.equiv h$.
]
#proof[
    必要性显然。反过来如果有 $f g tilde.equiv id_cal(D)$ 和 $h f tilde.equiv id_cal(C)$，
    则利用@axiom:结合单位逆 和 @axiom:水平复合 可得 $h tilde.equiv h f g tilde.equiv g$。此时易得 $g$ 或者 $h$ 就是 $f$ 的逆。
]

#note-box[
    注意由上面引理立刻得到函子的逆在同构意义下唯一，记为 $f^(-1): cal(D) -> cal(C)$。
]

#lemma[
    如果函子 $f:cal(C) -> cal(D)$ 和 $f' : cal(D) -> cal(E)$ 是范畴等价，其逆为 $g : cal(D) -> cal(C)$ 和 $g' : cal(E) -> cal(D)$,
    那么其复合 $f'f : cal(C) -> cal(E)$ 也是范畴等价，并且有逆 $g g' : cal(E) -> cal(C)$.
]<lemma:范畴等价的复合还是等价>
#proof[
    同样借助@axiom:结合单位逆 和 @axiom:水平复合 可得 $f' f g g' tilde.equiv f'g' tilde.equiv id_cal(E)$ 以及
    $g g' f' f tilde.equiv g f tilde.equiv id_cal(C)$.
]

#lemma[
    范畴等价满足三选二性质：给定函子 $f : cal(C) -> cal(D)$ 和 $g : cal(D) -> cal(E)$, 如果 $f,g$ 和 $g f$ 这三个函子中有两个是范畴等价，那么剩下一个也是。
]
#proof[
    如果 $f,g$ 是等价，则根据@lemma:范畴等价的复合还是等价 可以得到 $g f$ 是范畴等价。如果 $f$ 和 $g f$ 是等价，那么 $g$ 可以写作
    $g tilde.equiv g compose id_cal(D) tilde.equiv g compose f compose f^(-1) = g f compose f^(-1)$, 也就是两个范畴等价的复合，那么还是范畴等价。
    类似地可以证明 $g$ 和 $g f$ 是范畴等价时，$f$ 也是范畴等价。 
]

== 对象，态射
我们希望普通范畴是一种特殊的无穷范畴，为此有：
#axiom(title: "C")[
    每个普通范畴都是无穷范畴。 每个普通的函子 $f: cal(C) -> cal(D)$ 是无穷范畴之间的函子。每个普通的自然同构 $alpha: f tilde.equiv f'$ 是无穷范畴的函子之间的自然同构。
]
借助这个公理，我们可以讨论无穷范畴的对象了。设 $[n]$ 表示标准单形，也就是这样的普通范畴：
#nonum-equation($[n] = { 0 <= 1 <= dots.h.c <= n}$)
又设 $d_i,s_i$ 分别是面映射和退化映射。那么有
#definition[
    设 $cal(C)$ 是无穷范畴。
    #enum(numbering: "(1)")[
        $cal(C)$ 的对象指的是函子 $x : [0] -> cal(C)$。
    ][
        $cal(C)$ 的态射（可以称为 $0$-态射）是函子 $f:[1] -> cal(C)$。而 $f$ 的*源*与*目标*分别记作 $f(0)$ 和 $f(1)$, 定义为:
        #nonum-equation($
                          f(0): [0] -->^(d_1) [1] -->^f cal(C)
                          "    和    "
                          f(1): [0] -->^(d_0) [1] -->^f cal(C)
                        $)
        而 $f : x -> y$ 表示有自然同构 $x tilde.equiv f(0)$ 和 $y tilde.equiv f(1)$。
    ][
        $cal(C)$ 中的*交换三角*指的是函子 $sigma : [2] -> cal(C)$. 交换三角经常记为
        #align(center, commutative-diagram(
        node((1, 0), $x$),
        node((0, 1), $y$),
        node((1, 2), $z$),
        arr((1, 0), (0, 1), $f$),
        arr((0, 1), (1, 2), $g$),
        arr((1, 0), (1, 2), $h$, label-pos: right),
    ))
    这里 $f = sigma compose d_2$, $g = sigma compose d_0$, $h = sigma compose d_1$。
    ]
]

#example[
    给定 $cal(C)$ 中的一个对象 $x$, 它是函子 $x : [0] -> cal(C)$.
    我们定义它的单位态射 $id_x$ 是复合函子 $[1]->^(s_0) [0] ->^x cal(C)$. 由于下列两个复合显然是自然同构：
    #nonum-equation($
                      [0] -->^(d_1) [1] -->^(s_0) [0]
                      "    和    "
                      [0] -->^(d_0) [1] -->^(s_0) [0]
                    $)
    因此 $id_x$ 的源和目标都同构于 $x$.
]

#lemma[
    对每个态射 $f : x -> y$，有交换三角
    #align(center)[
        #commutative-diagram(
        node((1, 0), $x$),
        node((0, 1), $x$),
        node((1, 2), $y$),
        arr((1, 0), (0, 1), $id_x$),
        arr((0, 1), (1, 2), $f$),
        arr((1, 0), (1, 2), $f$, label-pos: right),
    )
    和
    #commutative-diagram(
        node((1, 0), $x$),
        node((0, 1), $y$),
        node((1, 2), $y$),
        arr((1, 0), (0, 1), $f$),
        arr((0, 1), (1, 2), $id_y$),
        arr((1, 0), (1, 2), $f$, label-pos: right),
    )
    ]
]
#proof[
    显然对于左图，这个 $sigma : [2] -> cal(C)$ 应当满足
    #nonum-equation[$
            sigma(0) &= f(0) \
            sigma(1) &= f(0) \
            sigma(2) &= f(1)
    $]
    但是我们不能认为 $cal(C)$ 当中有集合论意义上的对象，我们需要把 $cal(C)$ 当做一个整体，考虑它和其他对象之间的关系。
    因此我们考虑函子 $s_0 : [2] -> [1]$, 它把 $0,1$ 映射为 $0$，把 $2$ 映射为 $1$。
    这样我们注意到有函子 $sigma = f compose s_0 : [2] -> cal(C)$。 于是容易验证 $sigma compose d_0 = f$ 以及
    $sigma compose d_1 = f$。 而 $s_0 compose d_2$ 把 $[1]$ 映射为 $[0]$, 因此态射 $sigma compose d_2$ 的源和目标都是 $f(0)$，以及 $sigma compose d_2 = id_x$。对右图类似。
]

== 基本构造
普通范畴论中可以从两三个对象创造处新对象，本节给出它们的无穷范畴版本。它们都是普通范畴论中的相应对象直接推广，但是要给出相等的程度，也就是把 $=$ 改为 $tilde.equiv$，并且给出相应的自然同构。

=== 始对象和终对象
#axiom(title: "B.1")[
    空范畴 $emptyset$ 是无穷范畴里面的始对象：对每个无穷范畴 $cal(C)$，存在一个函子 $emptyset -> cal(C)$，如果有两个函子 $f,f': emptyset -> cal(C)$, 则存在自然同构 $f tilde.equiv f'$。
]

#axiom(title: "B.2")[
    范畴 $[0]$ 是无穷范畴里面的终对象：对每个无穷范畴 $cal(C)$，存在一个函子 $p_cal(C) : cal(C) -> [0]$，如果有两个函子 $f,f':cal(C) -> [0]$，则存在自然同构 $f tilde.equiv f'$。
]
我们经常用 $*$ 表示 $[0]$。

#definition[
    设 $cal(C),cal(D)$ 是两个无穷范畴，$x$ 是 $cal(D)$ 中的某个对象。我们定义*常函子* $c_x : cal(C) -> cal(D)$ 为复合
    #nonum-equation($
                      c_x : cal(C) -> [0] ->^x cal(D)
                    $)
    
    如果函子 $cal(C) -> *$ 是范畴等价，那么我们说 $cal(C)$ 是*可缩的(contractible)*。
]
#note-box[
    可缩范畴的定义显然来自代数拓扑当中的可缩空间。自然有命题：$cal(C)$ 是可缩的当且仅当存在对象 $x : * -> cal(C)$ 使得常态射
    $c_x : cal(C) -> cal(C)$ 自然同构于 $id_cal(C)$，此时这样一个自然同构 $H: c_x tilde.equiv id_cal(C)$ 称为 $cal(C)$ 在
    $x$ 上的*收缩(contraction)*。证明过程和代数拓扑中一样。
]

#axiom(title: "B.1'")[
    无穷范畴 $emptyset$ 是严格始对象：每个函子 $cal(C) -> emptyset$ 是等价。
]

=== 乘积和余积
#axiom(title: [B.3 $infinity$-范畴的乘积])[
    两个无穷范畴 $cal(C), cal(D)$ 的乘积，由对象 $cal(C) times cal(D)$ 和两个函子 
    $"pr"_cal(C) : cal(C) times cal(D) -> cal(C)$，$"pr"_cal(D) : cal(C) times cal(D) -> cal(D)$，它们称为标准投射函子。
    它们满足乘积的泛性质，但是要把等号 $=$ 改为存在自然变换 $tilde.equiv$，包括唯一性也要改为在自然同构意义下唯一。
    若有函子 $f: cal(T) -> cal(C)$ 和 $g: cal(T) -> cal(D)$，则它们的乘积表示为 $(f,g)$。

    这条公理说的就是任意两个无穷范畴都存在乘积范畴。
]<axiom:乘积>

#lemma[
    对于无穷范畴 $cal(C), cal(D)$，函子 $("pr"_cal(D),"pr"_cal(C)): cal(C) times cal(D) -> cal(D) times cal(C)$ 
    是范畴等价，逆函子就是 $("pr"_cal(C),"pr"_cal(D)): cal(D) times cal(C) -> cal(C) times cal(D)$
]
这个引理给出了乘积的交换律。

#lemma[
    对无穷范畴 $cal(C)$，标准投射函子 $"pr"_cal(C): cal(C) times * -> cal(C)$ 是等价，
    逆就是 $(id_cal(C),p_cal(C)): cal(C) -> cal(C) times *$
]
这个引理指出终范畴 $*$ 是乘积的单位元。

对于结合律，有
#lemma[
    对无穷范畴 $cal(C),cal(D),cal(E)$，函子 
    $("pr"_cal(C) compose "pr"_(cal(C) times cal(D)), ("pr"_cal(D) compose "pr"_(cal(C) times cal(D)), "pr"_cal(E))) : (cal(C) times cal(D)) times cal(E) -> cal(C) times (cal(D) times cal(E))$ 是范畴等价。
]

#axiom(title: [B.4 $infinity$-范畴的余积])[
    是上面公理的对偶版本，余积用 $union.sq$ 表示。标准插入函子用 $i_cal(C)$ 和 $i_cal(D)$ 来表示，
    而函子 $f : cal(C) -> cal(T)$ 和 $g : cal(D) -> cal(T)$ 的余积用 $angle.l f,g angle.r$ 表示。
    
    这条公理说任意两个无穷范畴 $cal(C), cal(D)$ 都存在余积 $cal(C) union.sq cal(D)$。
]

对余积也有类似乘积的交换律，结合律和单位元，这里余积的单位元是始范畴 $emptyset$。

#remark[
    无穷范畴乘积和余积具有函子性：给定任意两个函子 $f : cal(C) -> cal(C)'$ 和 $g : cal(D) -> cal(D)'$，那么有函子
    #nonum-equation($
        f times g &:= (f compose "pr"_cal(C) , g compose "pr"_cal(D)) : cal(C) times cal(D) --> cal(C)' times cal(D)' \
        f union.sq g &:= angle.l i_cal(C') compose f, i_cal(D') compose g angle.r : cal(C) union.sq cal(D) --> cal(C)' union.sq cal(D)'
    $)
    这个构造具有函子性：
    #nonum-equation($
        id_cal(C) times id_cal(D) &tilde.equiv id_cal(C times D) #h(2em)
        (f' times g') compose (f times g) &tilde.equiv (f' compose f) times (g' compose g) \
        id_cal(C) union.sq id_cal(D) &tilde.equiv id_cal(C union.sq D) #h(2em)
        (f' union.sq g') compose (f union.sq g) &tilde.equiv (f' compose f) union.sq (g' compose g)
    $)
]

=== 无穷范畴的拉回
拉回要复杂一点。
#axiom(title: "B.5 无穷范畴的拉回")[
    给定两个函子 $f: cal(C) -> cal(E)$ 和 $f: cal(D) -> cal(E)$，则存在它们的*拉回*，
    也称为 $cal(C)$ 和 $cal(D)$ 在 $cal(E)$ 上的*纤维积*，记为 $cal(C times_E D)$，它是无穷范畴，并且还有两个标准投射
    $"pr"_cal(C) : cal(C) -> cal(C times_E D)$ 和 $"pr"_cal(C) : cal(C) -> cal(C times_E D)$。
    它们有交换图，当然是自然同构意义下，此后不再专门说明：
    #align(center, commutative-diagram(
        node((0, 0), [$cal(C times_E D)$]),
        node((0, 1), [$cal(C)$]),
        node((1, 0), [$cal(D)$]),
        node((1, 1), [$cal(E)$]),
        arr((0, 0), (0, 1), [$"pr"_cal(C)$]),
        arr((0, 0), (1, 0), [$"pr"_cal(D)$], label-pos: right),
        arr((0, 1), (1, 1), [$f$]),
        arr((1, 0), (1, 1), [$g$], label-pos: left),
    ))

    给定两个函子 $t_1 : cal(T) -> cal(C)$ 和 $t_2 : cal(T) -> cal(D)$，并且有自然同构
    $f compose t_1 tilde.equiv g compose t_2$，
    那么存在一个函子 $t = (t_1,t_2): cal(T) -> cal(C times_E D)$ 使得 $"pr"_cal(C) compose t tilde.equiv t_1$
    以及 $"pr"_cal(D) compose t tilde.equiv t_2$，用交换图表示是：
    #align(center, commutative-diagram(
        node((1, 1), [$cal(C times_E D)$]),
        node((1, 2), [$cal(C)$]),
        node((2, 1), [$cal(D)$]),
        node((2, 2), [$cal(E)$]),
        node((0, 0), [$T$]),
        arr((1, 1), (1, 2), [$"pr"_cal(C)$]),
        arr((1, 1), (2, 1), [$"pr"_cal(D)$], label-pos: right),
        arr((1, 2), (2, 2), [$f$]),
        arr((2, 1), (2, 2), [$g$], label-pos: left),
        arr((0, 0), (1, 1), [$t$], label-pos: 0, "dashed"),
        arr((0, 0), (1, 2), [$t_1$], curve: 30deg),
        arr((0, 0), (2, 1), [$t_2$], curve: -30deg, label-pos: right),
    ))

    对于唯一性，表述如下：如果有两个函子 $t,t' : cal(T) -> cal(C times_E D)$，以及两个自然同构
    $alpha : "pr"_cal(C) compose t tilde.equiv "pr"_cal(C) compose t'$ 和
    $beta: "pr"_cal(D) compose t tilde.equiv "pr"_cal(D) compose t'$，并且它们使得下图交换：
    #align(center, commutative-diagram(
        node((0, 0), [$f compose "pr"_cal(C) compose t$]),
        node((0, 1), [$f compose "pr"_cal(C) compose t'$]),
        node((1, 0), [$g compose "pr"_cal(D) compose t$]),
        node((1, 1), [$g compose "pr"_cal(D) compose t'$]),
        arr((0, 0), (1, 0), [$tilde.equiv$], label-pos: right),
        arr((0, 0), (0, 1), [$f compose alpha$], label-pos: left),
        arr((0, 1), (1, 1), [$tilde.equiv$]),
        arr((1, 0), (1, 1), [$g compose beta$]),
    ))
    则存在自然同构 $(alpha,beta): t tilde.equiv t'$ 使得有 $3$-同构 
    $"pr"_cal(C) compose (alpha,beta) tilde.equiv alpha$ 和
    $"pr"_cal(D) compose (alpha,beta) tilde.equiv beta$。
]

不难看出，这个公理实际上包含了@axiom:乘积：只要让 $cal(E) = *$ 即可。
用类似前面的办法，通过泛性质可以证明下列交换律，结合律还有单位元：设有函子 $cal(C ->E)$，$cal(D -> E)$ 和 $cal(B -> E)$，
于是就有范畴等价：
#nonum-equation($
                cal(C times_E D) &-->^tilde.equiv cal(D times_E C), \
                cal(B times_E (C times_E D)) &-->^tilde.equiv cal((B times_E C) times_E D), \
                cal(C times_E E) &-->^tilde.equiv cal(C)
                $)

类似地，拉回也具有函子性：如果有交换图
#align(center, commutative-diagram(
  node((0, 0), [$C$]),
  node((0, 1), [$E$]),
  node((0, 2), [$D$]),
  node((1, 0), [$C'$]),
  node((1, 1), [$E'$]),
  node((1, 2), [$D'$]),
  arr((0, 0), (0, 1), [$f$]),
  arr((0, 2), (0, 1), [$g$], label-pos: right),
  arr((0, 0), (1, 0), [$phi$], label-pos: right),
  arr((0, 1), (1, 1), [$chi$]),
  arr((0, 2), (1, 2), [$psi$]),
  arr((1, 0), (1, 1), [$f'$], label-pos: right),
  arr((1, 2), (1, 1), [$g'$]),
))
则有函子
#nonum-equation($
        phi times_chi psi := (phi compose "pr"_cal(C), psi compose "pr"_cal(D)) :
        cal(C times_E D) --> cal(C' times_E' D')
                $)
不难证明这个函子对 $phi,psi,chi$ 具有函子性：如果设 $C'=C$，$E' = D' = E$，$phi = id_cal(C)$，$chi = id_E$，$psi=g$
并且 $g$ 是范畴等价，那么 $cal(C times_E D) -> cal(C)$ 也是范畴等价，注意此时这个函子与 $"pr"_cal(C)$ 自然同构。

拉回称为纤维积，这允许我们定义函子的纤维：
#definition[
    设 $f:cal(C) -> cal(D)$ 是函子。对每个 $cal(D)$ 的对象 $x$，我们定义 $f$ 在 $x$ 上的纤维 $f^(-1)(x)$ 为拉回
    // https://t.yw.je/#N4Igdg9gJgpgziAXAbVABwnAlgFyxMJZABgBpiBdUkANwEMAbAVxiRADMA9ACgFoBGAJTcAHoJABfUuky58hFP3JVajFmwDGjbgGFxUmdjwEiS-ivrNWiEFobcAIvukgMR+UTLnql9TYBUkiowUADm8ESg7ABOEAC2SGQgOBBI-AYcsQmISSlIAMwZMfEF1HmIAExFWWllqZU+atYcQRJAA
#align(center, commutative-diagram(
  node((0, 0), [$f^(-1)(x)$]),
  node((0, 1), [$cal(C)$]),
  node((1, 1), [$cal(D)$]),
  node((1, 0), [$*$]),
  arr((0, 0), (0, 1), []),
  arr((0, 0), (1, 0), []),
  arr((1, 0), (1, 1), []),
  arr((0, 1), (1, 1), [$f$]),
))
]

=== 余积的泛性质
#axiom(title: "B.4'")[
    #enum(numbering: "(1)")[
        对于函子 $f: cal(C') -> cal(C)$ 和 $g: cal(D') -> cal(D)$，交换图
        // https://t.yw.je/#N4Igdg9gJgpgziAXAbVABwnAlgFyxMJZABgBpiBdUkANwEMAbAVxiRAGNGAKAYQHIAlCAC+pdJlz5CKAIzkqtRizacGvPgAImYKQDo4ARw0ARQSLEgM2PASJkZC+s1aIQPc+OtSich9SfKrqq8WjoE+kbGQsIKMFAA5vBEoABmAE4QALZIZCA4EEgATNQMdABGMAwAChI20iBpWPEAFjgg-kouICke3RnZiLn5SHKKzmxYAPrB-NEW6VlF1MOIAMwd465TM3Op-SPLBWsbgd2heoYa8SIUwkA
        #align(center)[#commutative-diagram(
            node((0, 0), [$cal(C')$]),
            node((0, 1), [$cal(C' union.sq D')$]),
            node((1, 0), [$C$]),
            node((1, 1), [$cal(C union.sq D)$]),
            arr((0, 0), (1, 0), [$f$], label-pos: right),
            arr((0, 0), (0, 1), [$i_cal(C')$]),
            arr((1, 0), (1, 1), [$i_cal(C)$]),
            arr((0, 1), (1, 1), [$f union.sq g$]),
        ) #h(3em) #commutative-diagram(
            node((0, 0), [$cal(D')$]),
            node((0, 1), [$cal(C' union.sq D')$]),
            node((1, 0), [$D$]),
            node((1, 1), [$cal(C union.sq D)$]),
            arr((0, 0), (1, 0), [$g$], label-pos: right),
            arr((0, 0), (0, 1), [$i_cal(D')$]),
            arr((1, 0), (1, 1), [$i_cal(D)$]),
            arr((0, 1), (1, 1), [$f union.sq g$]),
        )]
        是拉回。
    ][
        若有函子 $h: cal(E) -> cal(C union.sq D)$，那么函子
        #nonum-equation($
                angle.l "pr"_cal(E), "pr"_cal(E) angle.r : 
                cal((E times_(C union.sq D) C) union.sq (E times_(C union.sq D) D)) --> cal(E)
                $)
        是等价。
    ]
]
这个公理的集合论版本是，若有映射 $S -> T_0 union.sq T_1$，则 $S$ 可以表示为 $T_0$ 和 $T_1$ 的原像的不交并。

=== 函子范畴
#axiom(title: "B.6")[
    设 $cal(C),cal(D)$ 是两个无穷范畴，则存在无穷范畴 $"Fun"(cal(C),cal(D))$，称为 $cal(C),cal(D)$ 之间的*函子范畴*。
    它满足*柯里化(currying)*性质：对另一无穷范畴 $cal(E)$ 和任意函子 $f: cal(E times C) -> cal(D)$，
    都有函子 $f_c: E -> "Fun"(cal(C),cal(D))$。反过来也要满足*反柯里化(uncurrying)*性质：
    对任意函子 $g : cal(E) -> "Fun"(cal(C), cal(D))$ 都有一个函子 $g^u: cal(E times C) -> cal(D)$。
    这两个操作要在自然同构意义下可逆：$f tilde.equiv (f_c)^u$ 和 $g tilde.equiv (g^u)_c$。

    当有函子 $f,f': cal(E times C) -> cal(D)$ 的自然同构 $alpha: f tilde.equiv f'$ 时，
    就有自然同构 $alpha_c : f_c tilde.equiv f'_c$，称为 $alpha$ 的柯里化。
    反过来若有 $g,g' : cal(E) -> "Fun"(cal(C), cal(D))$ 的自然同构 $beta: g tilde.equiv g'$，
    则有自然同构 $beta^u : g^u tilde.equiv (g')^u$。
    最后我们要求有 $3$-同构 $(alpha_c)^u tilde.equiv alpha$ 和 $(beta^u)_c tilde.equiv beta$。
]

#note-box[
    如果 $cal(E) = *$，那么 $"Fun"(cal(C),cal(D))$ 的对象 $* -> "Fun"(cal(C),cal(D))$ 通过柯里化就对应于函子
    $C tilde.equiv * times cal(C) -> cal(D)$。也就是说 $"Fun"(cal(C),cal(D))$ 可以视为从 $cal(C)$ 和 $cal(D)$
    的函子组成的无穷范畴。
]

#axiom(title: [B.7 柯里化对 $cal(E)$ 具有函子性])[
    给定函子 $g: cal(E) -> "Fun"(cal(C), cal(D))$，若有 $h: cal(E') -> cal(E)$，
    则 $g compose h: cal(E') -> "Fun"(cal(C), cal(D))$ 的反柯里化应当和
    $g^u compose (h times id_cal(C)): cal(E' times C) -> D$ 自然同构，这是反柯里化对 $cal(E)$ 的函子性。

    给定函子 $f: cal(E times C) -> cal(D)$，若有 $h: cal(E') -> cal(E)$，则 
    $f compose (h times id_cal(C)): cal(E' times C) -> cal(D)$ 的柯里化应当和
    $f_c compose h : E' -> "Fun"(cal(C), cal(D))$ 自然同构，这是柯里化对 $cal(E)$ 的函子性。
]
柯里化的函子性和反柯里化的函子性可以互相推导，借助柯里化和反柯里化的一一对应即可。

#definition(title: "求值函子")[
    给定两个无穷范畴 $cal(C),cal(D)$，则*求值函子* $"ev": "Fun"(cal(C), cal(D)) times cal(C) -> cal(D)$ 定义为
    $"ev" := (id_("Fun"(cal(C),cal(D))))^u$ 也就是单位函子 
    $id_("Fun"(cal(C), cal(D))): "Fun"(cal(C), cal(D)) -> "Fun"(cal(C), cal(D))$ 的反柯里化。
    如果有 $cal(C)$ 的对象 $x$，则我们定义函子 $"ev"_x : "Fun"(cal(C), cal(D)) -> cal(D)$ 为复合
    #nonum-equation($
            "ev"_x: "Fun"(cal(C), cal(D)) tilde.eq "Fun"(cal(C), cal(D)) times * -->^(id times x)
            "Fun"(cal(C), cal(D)) times cal(C) -->^"ev" cal(D)
                    $)
    称为在 $x$ 处的求值函子。
]

#definition(title: "箭头范畴")[
    设 $cal(C)$ 是无穷范畴。我们把函子范畴 $"Fun"([1], cal(C))$ 称为 $cal(C)$ 的*箭头范畴*。
    注意到箭头范畴中的对象就是 $cal(C)$ 的态射。
]

#definition(title: "态射阿尼玛")[
    设 $cal(C)$ 是无穷范畴。给定两个对象 $x,y$，我们定义 *态射阿尼玛*#footnote["阿尼玛"这个名字是 _anima_ 的音译，
    意译通常是*无穷群胚*，但是这四个字音节较多，因此也有人意译为"生像"。] $"Hom"_cal(C)(x,y)$ 为求值函子的纤维，
    也就是如下拉回：
    #align(center, commutative-diagram(
        node((0, 0), [$"Hom"_cal(C)(x,y)$]),
        node((0, 1), [$"Fun"([1],cal(C))$]),
        node((1, 0), [$*$]),
        node((1, 1), [$cal(C times C)$]),
        arr((0, 0), (0, 1), []),
        arr((0, 0), (1, 0), []),
        arr((1, 0), (1, 1), [$(x,y)$]),
        arr((0, 1), (1, 1), [$("ev"_0, "ev"_1)$]),
        ))
]

#definition(title: "自然变换")[
    通过函子范畴可以定义无穷范畴函子之间的自然变换了（而不仅仅是自然同构），实际上就是如同一般范畴论定义为 
    $"Fun"(cal(C), cal(D))$ 中的态射，也就是函子 $[1] -> "Fun"(cal(C), cal(D))$。
    通过反柯里化，可以表示为函子 $[1] times cal(C) -> cal(D)$。我们把 $"Fun"(cal(C), cal(D))$ 的态射阿尼玛用
    $"Nat"(f,g)$ 来表示：
    #nonum-equation($
                      "Nat"(f,g) := "Hom"_("Fun"(cal(C), cal(D)))(f,g)
                    $)
]

== 交换方块公理，Segal 公理和 Rezk 公理
上一节介绍了无穷范畴 $cal(C)$ 中的对象，态射和交换三角。我们希望这些构造满足我们希望的性质，也就是普通的范畴中应该就有的性质。为此我们需要本节标题的三个公理，它们通俗地说可以这么表述：
- 态射的交换方块指的是函子 $[1] times [1] -> cal(C)$，而交换方块公理说的就是这个和两个交换三角一一对应。
- Segal 公理说的是对每对态射 $f : x -> y$ 和 $g: y -> z$（这样的态射称为可复合态射），都存在本质上唯一的交换三角。
- Rezk 公理说两个对象 $x tilde.equiv y$ 等价于一个态射 $f: x -> y$，它有逆态射 $g: y -> x$ 使得 $g f tilde.equiv id_x$ 以及 $f g tilde.equiv id_y$。

下面我们一个个介绍。

=== 交换方块公理

//= 拟范畴