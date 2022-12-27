-- 1

CREATE TABLE type_of_animal (
	id bigserial, 
	description_type text
);

CREATE TABLE specifics_of_animal (
	id bigserial, 
	color text
);

--2

INSERT INTO type_of_animal (description_type) 
Values
('cheetah'), 
('penguin'), 
('bear');

INSERT INTO specifics_of_animal(color) 
Values('yellow'), ('black'), ('brown');
