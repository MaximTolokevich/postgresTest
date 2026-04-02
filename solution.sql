-- Создаем таблицу для нашего "Калькулятора" или любой другой логики
DROP TABLE IF EXISTS operations;
CREATE TABLE operations (
                            id SERIAL PRIMARY KEY,
                            name TEXT NOT NULL,
                            val_a INTEGER,
                            val_b INTEGER,
                            result INTEGER
);

-- Наполняем тестовыми данными
INSERT INTO operations (name, val_a, val_b, result) VALUES
                                                        ('add', 10, 5, 15),
                                                        ('subtract', 20, 8, 12),
                                                        ('multiply', 4, 3, 12);


