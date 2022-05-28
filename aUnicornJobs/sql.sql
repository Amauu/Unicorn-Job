INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_unicorn', 'Unicorn', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_unicorn', 'Unicorn', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_unicorn', 'Unicorn', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
('unicorn', 0, 'barman', 'Barman', 500, '{}', '{}'),
('unicorn', 1, 'dancer', 'Danseur', 500, '{}', '{}'),
('unicorn', 50, 'dancer', 'Officier', 40, '{}', '{}'),
('unicorn', 3, 'vicebosss', 'Co-Gérant', 60, '{}', '{}'),
('unicorn', 4, 'boss', 'Gérant', 80, '{}', '{}');

INSERT INTO `jobs` (name, label) VALUES
	('unicorn','Unicorn')
;

INSERT INTO items (name, label, weight) VALUES
    ('menthe','Feuille de menthe', 50),
    ('rhum','Rhum', 50),
    ('coca','Coca', 50)
    ('whisky','Whisky', 50)
    ('whiskycoca','Whisky-Coca', 50)
    ('jusfruit','Jus de fruits', 50)
    ('sucreP','Sucre en Poudre', 50)
    ('rhumfruit','Rhum-jus de fruits', 50)
; 