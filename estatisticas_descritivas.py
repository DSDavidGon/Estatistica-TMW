# %%

import pandas as pd

df = pd.read_csv("data/points_tmw.csv")

df.head()

# %%

print("Estatísticas de posição para Transações")

min = df['qtdPontos'].min()
print("Minimo:", min)

media= df['qtdPontos'].mean()
print("Média:",media)

quartil_1 = df['qtdPontos'].quantile(0.25)
print("1º Quartil:",quartil_1)

mediana = df["qtdPontos"].median()
print("Mediana:", mediana)

quartil_3 = df["qtdPontos"].quantile(0.75)
print("3º Quartil:",quartil_3)

max = df["qtdPontos"].max()
print("Máximo:",max)

print("--------------------------------------")
df["qtdPontos"].describe()

# %%

usuarios = (df.groupby(["idUsuario"]).agg(
    {
        "idTransacao":"count",
        "qtdPontos":"sum",
    }
).reset_index())

usuarios

# %%

sumario = usuarios[['idTransacao','qtdPontos']].describe()

print("Estatísticas de posição para Usuários")
print(sumario.to_string())

