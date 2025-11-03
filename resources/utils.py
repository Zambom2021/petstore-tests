from faker import Faker
import random
import re
import os

fake = Faker()

def gera_pet_name():
    """
    Gera um nome de pet aleatório.
    Pode ser humano ou animal, dependendo do estilo.
    """
    # Combina nomes ou escolhe palavras divertidas
    nomes = [fake.first_name(), fake.word()]
    nome = random.choice(nomes)
    return nome.capitalize()

def gera_pet_id():
    """
    Gera um ID aleatório para o pet.
    Evita usar sempre o mesmo ID em testes.
    """
    return random.randint(10000, 99999) 

def gera_foto_url(nome_pet):
    """
    Gera uma URL aleatória simulando o link de uma imagem de pet.

    Exemplo de retorno:
    https://example.com/images/<nomePet>-4821.jpg

    """
    nome_formatado = re.sub(r'[^a-zA-Z0-9]', '-', nome_pet)
    numero_aleatorio = random.randint(1000, 9999)
    # url = f"http://localhost:8080/images/{nome_formatado}-{numero_aleatorio}.jpg"
    # return url
    # Caminho base local
    base_path = r"D:\Projetos_QA\Projects_Robot\PetStore\petstore\petstore-tests\images"
    filename = f"{nome_formatado}-{numero_aleatorio}.jpg"
    file_path = os.path.join(base_path, filename)

    return file_path
    

def gera_tags():
    tags_possiveis = ["vacina_em_dia", "amigavel", "filhote", "resgatado"]
    tag_escolhida = random.choice(tags_possiveis)
    return [{"id": random.randint(1, 100), "name": tag_escolhida}]


# Executa apenas se o arquivo for chamado diretamente
# if __name__ == "__main__":
#     nome_pet = gera_pet_name()
#     print(f"Nome do pet gerado: {nome_pet}")
