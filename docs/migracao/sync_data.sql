-- SYNC DATASET FROM GOOGLE SHEETS PLANILHA V2 (2026-07-29T21:52:05.909Z)
BEGIN;
DELETE FROM settlements WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM transactions WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM payables WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM receivables WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM commissions WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';
DELETE FROM sales WHERE company_id = 'e11042be-3d22-4048-9380-ac71e8dc9252';

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '1.1', 'Comissão', 'revenue', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '1.2', 'Investimento / Aporte', 'revenue', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '1.3', 'Outras Receitas', 'revenue', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '2.1', 'Marketing / Tráfego', 'expense', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '2.2', 'Repasse de Comissão', 'expense', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '2.3', 'Pessoal / Salários', 'expense', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '2.4', 'Impostos (DAS / Simples)', 'expense', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '2.5', 'Infraestrutura / Web', 'expense', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '2.6', 'Software / Assinaturas', 'expense', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '2.7', 'Equipamentos', 'expense', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '2.8', 'Contabilidade', 'expense', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO chart_accounts (id, company_id, code, name, type, is_active)
    VALUES (gen_random_uuid(), 'e11042be-3d22-4048-9380-ac71e8dc9252', '2.9', 'Outras Despesas', 'expense', TRUE)
    ON CONFLICT (company_id, code) DO UPDATE SET name = EXCLUDED.name;
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('54708615-edd2-469c-899b-513940503d36', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão 3 Vendas Soraya (Vista di Mari 1303, 1213 / MLar Cambeba 705) — Pt1', 'Vista di Mari', 5655.57, '2026-04-18', 'received', '2026-04-18', 5655.57, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('ded490f6-4c79-4326-b878-064e29a7510e', 'e11042be-3d22-4048-9380-ac71e8dc9252', '54708615-edd2-469c-899b-513940503d36', 5655.57, '2026-04-18');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('b0bd5ec9-7159-4582-8b53-dee9d497bfba', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 5655.57, '2026-04-18', 'Comissão 3 Vendas Soraya (Vista di Mari 1303, 1213 / MLar Cambeba 705) — Pt1', '54708615-edd2-469c-899b-513940503d36', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('2cad18af-932a-4c31-814b-0d2b64716373', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão 3 Vendas Soraya (Vista di Mari 1303, 1213 / MLar Cambeba 705) — Pt2', 'Vista di Mari', 4891, '2026-04-23', 'received', '2026-04-23', 4891, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('821f8c93-d244-4789-bfed-b4a8955124d8', 'e11042be-3d22-4048-9380-ac71e8dc9252', '2cad18af-932a-4c31-814b-0d2b64716373', 4891, '2026-04-23');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('c0587837-b7ba-4053-a4a3-2c0017f1ba52', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 4891, '2026-04-23', 'Comissão 3 Vendas Soraya (Vista di Mari 1303, 1213 / MLar Cambeba 705) — Pt2', '2cad18af-932a-4c31-814b-0d2b64716373', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('410fffe3-e551-49a1-b095-3506682c1646', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Aporte Reno', 'Reno', 5000, '2026-04-30', 'received', '2026-04-30', 5000, 'Aporte sócio');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('a0cd8a1f-2918-4be4-b065-042939a83a2a', 'e11042be-3d22-4048-9380-ac71e8dc9252', '410fffe3-e551-49a1-b095-3506682c1646', 5000, '2026-04-30');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('a5329ec4-8e89-499c-984e-b3dc7ae4e39d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 5000, '2026-04-30', 'Aporte Reno', '410fffe3-e551-49a1-b095-3506682c1646', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('feb9b551-77fa-48bb-b99a-5ad21a22c311', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Vibe Meireles Ap. 2103', 'Vibe Meireles', 24006.42, '2026-05-05', 'received', '2026-05-05', 24006.42, 'Corretor: Reno');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('861b5856-bf81-4889-ba1d-3ba937283f6b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'feb9b551-77fa-48bb-b99a-5ad21a22c311', 24006.42, '2026-05-05');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('2607c88e-61ae-4042-aee4-4f79065fbb01', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 24006.42, '2026-05-05', 'Comissão Venda Reno — Vibe Meireles Ap. 2103', 'feb9b551-77fa-48bb-b99a-5ad21a22c311', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('97cdf489-ca5b-43ba-bead-98c53e969ddb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bonus Venda Reno — Bella Aldeota (Mateus J.)', 'Bella Aldeota', 2990.57, '2026-05-18', 'received', '2026-05-18', 2990.57, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('7c47b34a-e14f-4928-a208-957ae337868b', 'e11042be-3d22-4048-9380-ac71e8dc9252', '97cdf489-ca5b-43ba-bead-98c53e969ddb', 2990.57, '2026-05-18');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('89014644-eda3-4f7f-92b3-6a428d7a567a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 2990.57, '2026-05-18', 'Bonus Venda Reno — Bella Aldeota (Mateus J.)', '97cdf489-ca5b-43ba-bead-98c53e969ddb', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('41187100-035b-4401-baaf-43201071267f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Bella Aldeota (Mateus J.)', 'Bella Aldeota', 10800.53, '2026-05-18', 'received', '2026-05-18', 10800.53, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('23117a90-1154-4b94-9d57-35783654b2b9', 'e11042be-3d22-4048-9380-ac71e8dc9252', '41187100-035b-4401-baaf-43201071267f', 10800.53, '2026-05-18');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('043a728c-75e6-48e2-ba45-4d5f36c8e0de', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 10800.53, '2026-05-18', 'Comissão Venda Reno — Bella Aldeota (Mateus J.)', '41187100-035b-4401-baaf-43201071267f', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('82b4b65b-1ae2-4e79-a342-565759a0d366', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno - Maré - Beatriz', 'Maré', 29365.41, '2026-05-18', 'received', '2026-05-18', 29365.41, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('4f028567-a0ed-467f-a63b-9cc157150eba', 'e11042be-3d22-4048-9380-ac71e8dc9252', '82b4b65b-1ae2-4e79-a342-565759a0d366', 29365.41, '2026-05-18');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('d91bdc0b-856c-41b8-a4a7-80b8629265a2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 29365.41, '2026-05-18', 'Comissão Venda Reno - Maré - Beatriz', '82b4b65b-1ae2-4e79-a342-565759a0d366', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('5f2ec30d-489c-4396-a1cd-2a2a00025337', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno - MLar Kennedy - Lia e Jonathan', 'MLar Kennedy', 14933.56, '2026-06-18', 'received', '2026-06-18', 14933.56, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('284c3d2b-692a-49b8-adeb-f4d4901acf9f', 'e11042be-3d22-4048-9380-ac71e8dc9252', '5f2ec30d-489c-4396-a1cd-2a2a00025337', 14933.56, '2026-06-18');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('5b3ea68b-15ee-4b87-886c-a65a2b3c6b8a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 14933.56, '2026-06-18', 'Comissão Venda Reno - MLar Kennedy - Lia e Jonathan', '5f2ec30d-489c-4396-a1cd-2a2a00025337', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('293b1c73-9ae7-4d90-8919-5c3fa0aec2c7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno - MLar  - Rafael Herminio', 'Mlar Jacarey', 13505.8, '2026-06-23', 'received', '2026-06-23', 13505.8, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('fff14433-0d1a-4e62-ad45-549b622f1bcd', 'e11042be-3d22-4048-9380-ac71e8dc9252', '293b1c73-9ae7-4d90-8919-5c3fa0aec2c7', 13505.8, '2026-06-23');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('08d4a3ba-a48e-45c4-96f8-a362ad8af63b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 13505.8, '2026-06-23', 'Comissão Venda Reno - MLar  - Rafael Herminio', '293b1c73-9ae7-4d90-8919-5c3fa0aec2c7', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('724d6f0f-47d8-48b7-ab9c-9dfc682ab264', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bonus Venda Reno - MLar Kennedy - Lia e Jonathan', 'MLar Kennedy', 2894.1, '2026-07-01', 'received', '2026-07-01', 2894.1, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('0b0e3879-524d-446d-94a9-04f04bae369f', 'e11042be-3d22-4048-9380-ac71e8dc9252', '724d6f0f-47d8-48b7-ab9c-9dfc682ab264', 2894.1, '2026-07-01');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('19246f42-e1e2-4cb1-afab-3ef91fde8d7c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 2894.1, '2026-07-01', 'Bonus Venda Reno - MLar Kennedy - Lia e Jonathan', '724d6f0f-47d8-48b7-ab9c-9dfc682ab264', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('ce9a65b5-696f-4807-96f1-6235a25a8249', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno - Gilson - Beatriz', 'Maré', 27351.44, '2026-06-01', 'received', '2026-06-01', 27351.44, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('c2e8cc81-e20b-4f96-a8fd-cfb6797b5c21', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ce9a65b5-696f-4807-96f1-6235a25a8249', 27351.44, '2026-06-01');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('17e03e86-ac5f-4652-a844-54e7ebe180f9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 27351.44, '2026-06-01', 'Comissão Venda Reno - Gilson - Beatriz', 'ce9a65b5-696f-4807-96f1-6235a25a8249', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('3173e048-c065-4bc4-8ea4-0713ce862e3c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Bella Aldeota', 'Bella Aldeota', 19526.19, '2026-07-13', 'received', '2026-07-13', 19526.19, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('56f28ca4-ac48-409b-92db-e657cda07c75', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3173e048-c065-4bc4-8ea4-0713ce862e3c', 19526.19, '2026-07-13');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('048e372a-1990-4217-b5bd-c2844ebfbe1a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 19526.19, '2026-07-13', 'Comissão Venda Reno — Bella Aldeota', '3173e048-c065-4bc4-8ea4-0713ce862e3c', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('2ede926a-73ed-4546-bc3a-a27f3f47ae82', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Bella Aldeota (Mateus J.)', 'Bella Aldeota', 10800.53, '2026-07-13', 'received', '2026-07-13', 10800.53, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('ac8cd4b6-9168-4b83-8ec9-8bb917e87f7b', 'e11042be-3d22-4048-9380-ac71e8dc9252', '2ede926a-73ed-4546-bc3a-a27f3f47ae82', 10800.53, '2026-07-13');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('a292925b-94f5-475b-b893-6609166178b6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 10800.53, '2026-07-13', 'Comissão Venda Reno — Bella Aldeota (Mateus J.)', '2ede926a-73ed-4546-bc3a-a27f3f47ae82', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('11c71578-30d8-4c4a-be82-d7a4a5ba1e50', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Maré (Mara)', 'Maré', 25038.04, '2026-07-13', 'received', '2026-07-13', 25038.04, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('24fb7adc-4b9c-4f62-8503-00ca7888b42b', 'e11042be-3d22-4048-9380-ac71e8dc9252', '11c71578-30d8-4c4a-be82-d7a4a5ba1e50', 25038.04, '2026-07-13');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('f2669fb2-bf20-432c-a0a0-5331a4cab569', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 25038.04, '2026-07-13', 'Comissão Venda Reno — Maré (Mara)', '11c71578-30d8-4c4a-be82-d7a4a5ba1e50', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('e06406c5-f9c7-4b9a-ab25-1c80d8b01b94', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Venda Reno — Bella Aldeota (Jaime)', 'Bella Aldeota', 17485.5, '2026-07-20', 'received', '2026-07-20', 17485.5, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('d2324d2c-ef43-46a4-bac8-3c36527951b4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'e06406c5-f9c7-4b9a-ab25-1c80d8b01b94', 17485.5, '2026-07-20');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('7328823b-043e-4dbd-ae2f-6b7987dd608c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 17485.5, '2026-07-20', 'Comissão Venda Reno — Bella Aldeota (Jaime)', 'e06406c5-f9c7-4b9a-ab25-1c80d8b01b94', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('ba152830-07e8-4ed1-9266-ee8fd41f9f8c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Investimento Tráfego - PraMorar', 'Bella Aldeota', 1900, '2026-07-20', 'received', '2026-07-20', 1900, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('1162faf8-2e64-47dc-b389-4d8fef196f85', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ba152830-07e8-4ed1-9266-ee8fd41f9f8c', 1900, '2026-07-20');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('2f094430-88d4-4cc1-af42-dc26aa43069f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 1900, '2026-07-20', 'Investimento Tráfego - PraMorar', 'ba152830-07e8-4ed1-9266-ee8fd41f9f8c', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('77dfcde9-966b-4717-ac62-f34524eaab9f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Viva Vida', 'Viva Vida Sul', 5788.2, '2026-07-21', 'received', '2026-07-21', 5788.2, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('cd8d955c-4d09-4742-8c6d-ff68d11809cd', 'e11042be-3d22-4048-9380-ac71e8dc9252', '77dfcde9-966b-4717-ac62-f34524eaab9f', 5788.2, '2026-07-21');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('116266bb-3479-4994-9930-218c4c64dd20', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 5788.2, '2026-07-21', 'Comissão Viva Vida', '77dfcde9-966b-4717-ac62-f34524eaab9f', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('9a7f6ad5-b94b-4a92-b3b1-2651257e3a3b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bella Aldeota - Investimento', 'Bella Aldeota', 1929.4, '2026-07-27', 'received', '2026-07-27', 1929.4, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('69bf209d-6e0b-441d-8a6e-50b8c8372978', 'e11042be-3d22-4048-9380-ac71e8dc9252', '9a7f6ad5-b94b-4a92-b3b1-2651257e3a3b', 1929.4, '2026-07-27');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('c82b9960-d48f-4c90-aa57-70977fdf8263', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 1929.4, '2026-07-27', 'Bella Aldeota - Investimento', '9a7f6ad5-b94b-4a92-b3b1-2651257e3a3b', 'Pix');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, received_at, received_amount, notes)
    VALUES ('7da4c773-2702-433f-864d-f1be1f7614ef', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bonus - Gilson', 'Bella Aldeota', 9647, '2026-07-27', 'received', '2026-07-27', 9647, '');

    INSERT INTO settlements (id, company_id, receivable_id, amount, settled_at)
    VALUES ('af7646bc-9037-4613-a7b8-d7a76898d411', 'e11042be-3d22-4048-9380-ac71e8dc9252', '7da4c773-2702-433f-864d-f1be1f7614ef', 9647, '2026-07-27');

    INSERT INTO transactions (id, company_id, type, amount, date, description, receivable_id, payment_method)
    VALUES ('2f3f0350-e871-4e5c-bdfe-14a3ce76ec79', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'income', 9647, '2026-07-27', 'Bonus - Gilson', '7da4c773-2702-433f-864d-f1be1f7614ef', 'Pix');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('6a635048-7f68-4deb-bd40-7590e4d84eaf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Compra 06 cabecas de carregadores', 'Amazon', 143.58, '2026-04-22', 'paid', '2026-04-22', 143.58, 'Pago - Comprovante - compra de 06 cabeças de carregadores.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d82cd6a3-ee76-4e59-925e-47a4a44392ad', 'e11042be-3d22-4048-9380-ac71e8dc9252', '6a635048-7f68-4deb-bd40-7590e4d84eaf', 143.58, '2026-04-22', 'Pago - Comprovante - compra de 06 cabeças de carregadores.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('7ea30739-b296-41b3-8aef-b5fc505e89b0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 143.58, '2026-04-22', 'Compra 06 cabecas de carregadores', '6a635048-7f68-4deb-bd40-7590e4d84eaf', 'Cartão', 'Pago - Comprovante - compra de 06 cabeças de carregadores.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('12bcee03-4b27-4224-9f26-71a779f37759', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Bella Aldeota e Bella Rio', 'Meta', 1000, '2026-04-23', 'paid', '2026-04-23', 1000, 'Pago - Saldo Campanha - Bella Aldeota e Bella Rio.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('7aa1332c-243c-4493-98da-bf5bd03380e9', 'e11042be-3d22-4048-9380-ac71e8dc9252', '12bcee03-4b27-4224-9f26-71a779f37759', 1000, '2026-04-23', 'Pago - Saldo Campanha - Bella Aldeota e Bella Rio.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('04dd9680-f65a-4126-935d-3501ab4e4b39', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-04-23', 'Saldo Meta — Bella Aldeota e Bella Rio', '12bcee03-4b27-4224-9f26-71a779f37759', 'Pix', 'Pago - Saldo Campanha - Bella Aldeota e Bella Rio.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('e777b37a-5f78-45e2-9d2e-cbaf468fcfee', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — BSWave e Maré', 'Meta', 750, '2026-04-23', 'paid', '2026-04-23', 750, 'Pago - Saldo Campanha - BS Wave e Mare.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('63b96b27-2b96-4a0d-9ac4-08d8c2ae6ddb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'e777b37a-5f78-45e2-9d2e-cbaf468fcfee', 750, '2026-04-23', 'Pago - Saldo Campanha - BS Wave e Mare.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('5d5fbda4-6c73-47d2-80b4-050a9de0a09e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 750, '2026-04-23', 'Saldo Meta — BSWave e Maré', 'e777b37a-5f78-45e2-9d2e-cbaf468fcfee', 'Pix', 'Pago - Saldo Campanha - BS Wave e Mare.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('8d7e0596-c306-4267-9151-37728fb9df10', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — MLar Cambeba e Lago', 'Meta', 750, '2026-04-23', 'paid', '2026-04-23', 750, 'Pago - Saldo Campanha - MLar Cambeba e Lago.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('aa471bf0-e3c5-4ae1-a101-b1e3b527aff5', 'e11042be-3d22-4048-9380-ac71e8dc9252', '8d7e0596-c306-4267-9151-37728fb9df10', 750, '2026-04-23', 'Pago - Saldo Campanha - MLar Cambeba e Lago.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('de1b6400-5b87-45e0-b0b3-0c533df1554c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 750, '2026-04-23', 'Saldo Meta — MLar Cambeba e Lago', '8d7e0596-c306-4267-9151-37728fb9df10', 'Pix', 'Pago - Saldo Campanha - MLar Cambeba e Lago.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('f2fafd2a-3813-40c0-99c8-ab2e667a3625', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google — GAds Internacional', 'Google', 400, '2026-04-23', 'paid', '2026-04-23', 400, 'Pago - Saldo Campanha - GAds Internacional.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d347c407-6003-428c-8288-e43d9d90c915', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f2fafd2a-3813-40c0-99c8-ab2e667a3625', 400, '2026-04-23', 'Pago - Saldo Campanha - GAds Internacional.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('cc231425-18ba-47a4-be81-f249273b7b10', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-04-23', 'Saldo Google — GAds Internacional', 'f2fafd2a-3813-40c0-99c8-ab2e667a3625', 'Pix', 'Pago - Saldo Campanha - GAds Internacional.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('cebfa9f5-f28f-457c-ad26-e033b88307c1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Compra 08 cabos carregadores + Régua', 'Amazon', 138.03, '2026-04-23', 'paid', '2026-04-23', 138.03, '');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('95d05e2a-b9aa-4f4b-93a6-e7763c1d0011', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'cebfa9f5-f28f-457c-ad26-e033b88307c1', 138.03, '2026-04-23', '');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('1dc8f220-54fe-453f-9d8d-9ed24ec0bd16', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 138.03, '2026-04-23', 'Compra 08 cabos carregadores + Régua', 'cebfa9f5-f28f-457c-ad26-e033b88307c1', 'Cartão', '');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('62f66b77-5061-404f-aa26-3a6d54d124b3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Compra 10 suportes de celulares', 'Mercado Livre', 41.12, '2026-04-24', 'paid', '2026-04-24', 41.12, '10 suportes de celulares.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('29d79c44-0d3d-45f0-b4e1-5f0ffb3a10f9', 'e11042be-3d22-4048-9380-ac71e8dc9252', '62f66b77-5061-404f-aa26-3a6d54d124b3', 41.12, '2026-04-24', '10 suportes de celulares.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('38e82ca2-df11-47f9-9e50-05969759db76', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 41.12, '2026-04-24', 'Compra 10 suportes de celulares', '62f66b77-5061-404f-aa26-3a6d54d124b3', 'Cartão', '10 suportes de celulares.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('2ddfef8d-9754-4f08-bdc2-1c351abdb937', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google — GAds Fortaleza RE9 Imob', 'Google', 1000, '2026-04-27', 'paid', '2026-04-27', 1000, 'Pago - Saldo Campanha - GAds Fortaleza.png');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5751d042-b099-4f52-aaff-185e9ee34264', 'e11042be-3d22-4048-9380-ac71e8dc9252', '2ddfef8d-9754-4f08-bdc2-1c351abdb937', 1000, '2026-04-27', 'Pago - Saldo Campanha - GAds Fortaleza.png');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('8bf6d10f-d69f-4f91-a377-e60005a2e8e9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-04-27', 'Saldo Google — GAds Fortaleza RE9 Imob', '2ddfef8d-9754-4f08-bdc2-1c351abdb937', 'Pix', 'Pago - Saldo Campanha - GAds Fortaleza.png');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('5a269782-dfc1-4baa-940e-bb544cbc9aa8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — MLar Cambeba e Lago', 'Meta', 500, '2026-04-27', 'paid', '2026-04-27', 500, 'Pago - Saldo Campanha - Meta MLar Cambeba e Lago.png');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('a29d12b1-2d2f-447a-aa45-1fc3ebbd5580', 'e11042be-3d22-4048-9380-ac71e8dc9252', '5a269782-dfc1-4baa-940e-bb544cbc9aa8', 500, '2026-04-27', 'Pago - Saldo Campanha - Meta MLar Cambeba e Lago.png');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('00f16009-57c8-4fe1-ba8f-bfbeb98aaef1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-04-27', 'Saldo Meta — MLar Cambeba e Lago', '5a269782-dfc1-4baa-940e-bb544cbc9aa8', 'Pix', 'Pago - Saldo Campanha - Meta MLar Cambeba e Lago.png');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('eddd9a67-9208-43c4-97dc-70fb9e59adf4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Atlântico, Orizon e Seano', 'Meta', 500, '2026-05-02', 'paid', '2026-05-02', 500, 'Pago - Saldo Meta - AtlanticoSeanoOrizon - Maio26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b6cab4bc-45b3-42c0-86a8-c60d88d7a751', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'eddd9a67-9208-43c4-97dc-70fb9e59adf4', 500, '2026-05-02', 'Pago - Saldo Meta - AtlanticoSeanoOrizon - Maio26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('4913b009-e47d-41ae-9991-256d037afeb0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-02', 'Saldo Meta — Atlântico, Orizon e Seano', 'eddd9a67-9208-43c4-97dc-70fb9e59adf4', 'Cartão', 'Pago - Saldo Meta - AtlanticoSeanoOrizon - Maio26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('3d9f1de1-0d29-4e47-bda5-056f5e507ec6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Bella Aldeota e Bella Rio', 'Meta', 1000, '2026-05-02', 'paid', '2026-05-02', 1000, 'Pago - Saldo Meta - Bella Aldeota e Bella Rio - Maio26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('dd767ad4-3c1c-4bb1-a40c-80a175b55ccf', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3d9f1de1-0d29-4e47-bda5-056f5e507ec6', 1000, '2026-05-02', 'Pago - Saldo Meta - Bella Aldeota e Bella Rio - Maio26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('58a53d84-ff58-47d9-a5da-cc861636baf7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-02', 'Saldo Meta — Bella Aldeota e Bella Rio', '3d9f1de1-0d29-4e47-bda5-056f5e507ec6', 'Cartão', 'Pago - Saldo Meta - Bella Aldeota e Bella Rio - Maio26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('df7ea192-a8c0-4bb0-898c-42fdf9853d26', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — BSWave e Maré', 'Meta', 400, '2026-05-02', 'paid', '2026-05-02', 400, 'Pago - Saldo Meta - BSWave e Mare - Maio26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2cd6bfb3-4bc9-4b43-8b3b-a541ad7ea333', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'df7ea192-a8c0-4bb0-898c-42fdf9853d26', 400, '2026-05-02', 'Pago - Saldo Meta - BSWave e Mare - Maio26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('92c80c58-f20f-4369-8aa9-b9c74da75679', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-05-02', 'Saldo Meta — BSWave e Maré', 'df7ea192-a8c0-4bb0-898c-42fdf9853d26', 'Cartão', 'Pago - Saldo Meta - BSWave e Mare - Maio26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('1ba2c809-9bd1-4837-a3cf-1d16c50e48c1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — MLar Cambeba e Lago', 'Meta', 400, '2026-05-02', 'paid', '2026-05-02', 400, 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d1d13d49-1d0e-4a30-8e82-4c103713c057', 'e11042be-3d22-4048-9380-ac71e8dc9252', '1ba2c809-9bd1-4837-a3cf-1d16c50e48c1', 400, '2026-05-02', 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('60b09243-fdb6-43d2-ab65-c526e4e5749c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-05-02', 'Saldo Meta — MLar Cambeba e Lago', '1ba2c809-9bd1-4837-a3cf-1d16c50e48c1', 'Cartão', 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('bb10410d-ae51-494d-b6b1-120319ee5528', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pagamento Comissão Corretor Reno — Vibe 2103', 'Reno', 12003.21, '2026-05-05', 'paid', '2026-05-05', 12003.21, 'Pago - Comissão Reno - Vibe Meireles Ap2103.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('a70c48a0-e35c-4738-b446-91f80421c99c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'bb10410d-ae51-494d-b6b1-120319ee5528', 12003.21, '2026-05-05', 'Pago - Comissão Reno - Vibe Meireles Ap2103.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('5a2e6b33-740f-436a-a7f2-d24f07739018', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 12003.21, '2026-05-05', 'Pagamento Comissão Corretor Reno — Vibe 2103', 'bb10410d-ae51-494d-b6b1-120319ee5528', 'Pix', 'Pago - Comissão Reno - Vibe Meireles Ap2103.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('0e6772b6-5667-423c-a941-3687b76603e4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pagamento Angélica — Vibe Meireles 2103', 'Angélica', 500, '2026-05-05', 'paid', '2026-05-05', 500, 'Pago - Comissao1 Angelica Mai26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('645ea1e2-c652-4134-9322-8b0f0f35af09', 'e11042be-3d22-4048-9380-ac71e8dc9252', '0e6772b6-5667-423c-a941-3687b76603e4', 500, '2026-05-05', 'Pago - Comissao1 Angelica Mai26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('cfd402d4-ecbe-478d-b3b3-8a792855ee30', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-05', 'Pagamento Angélica — Vibe Meireles 2103', '0e6772b6-5667-423c-a941-3687b76603e4', 'Pix', 'Pago - Comissao1 Angelica Mai26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('51302965-d4d6-428f-94fc-6f8e5a131a34', 'e11042be-3d22-4048-9380-ac71e8dc9252', '50% Placas Porta RE9 — CEPlacas', 'CE Placas', 375, '2026-05-05', 'paid', '2026-05-05', 375, 'Pago - Placas RE9 pt1.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('33d11c8d-7be4-4a58-afda-48caee397244', 'e11042be-3d22-4048-9380-ac71e8dc9252', '51302965-d4d6-428f-94fc-6f8e5a131a34', 375, '2026-05-05', 'Pago - Placas RE9 pt1.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('be9aebce-728b-4aa5-85aa-723a90ab01d9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 375, '2026-05-05', '50% Placas Porta RE9 — CEPlacas', '51302965-d4d6-428f-94fc-6f8e5a131a34', 'Pix', 'Pago - Placas RE9 pt1.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('efe75e83-0eab-4263-9c6c-b96728762b26', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Atlântico, Orizon e Seano', 'Meta', 2652.04, '2026-05-07', 'paid', '2026-05-07', 2652.04, 'Pago - Saldo Meta - AtlanticoSeanoOrizon 2 - Maio26.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('91eabdc3-ca2a-4d24-86f5-749824bc3720', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'efe75e83-0eab-4263-9c6c-b96728762b26', 2652.04, '2026-05-07', 'Pago - Saldo Meta - AtlanticoSeanoOrizon 2 - Maio26.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('22fec0ef-5041-4ebe-a3ca-6b10b8842cc3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2652.04, '2026-05-07', 'Saldo Meta — Atlântico, Orizon e Seano', 'efe75e83-0eab-4263-9c6c-b96728762b26', 'Pix', 'Pago - Saldo Meta - AtlanticoSeanoOrizon 2 - Maio26.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('dbed312b-184c-471f-a193-240238827bf7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Bella Aldeota e Bella Rio', 'Meta', 2000, '2026-05-07', 'paid', '2026-05-07', 2000, 'Pago - Saldo Meta - BellaAldeota e Bella Rio 2 - Maio26.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('39e3bcf4-4017-43d8-ace7-ead2b7117768', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'dbed312b-184c-471f-a193-240238827bf7', 2000, '2026-05-07', 'Pago - Saldo Meta - BellaAldeota e Bella Rio 2 - Maio26.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('ef87c475-15bc-48ac-9196-1dd62865135a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2000, '2026-05-07', 'Saldo Meta — Bella Aldeota e Bella Rio', 'dbed312b-184c-471f-a193-240238827bf7', 'Pix', 'Pago - Saldo Meta - BellaAldeota e Bella Rio 2 - Maio26.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('e336bfec-7aa8-4ce7-9e44-21f6286de1a7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Curso para Corretores — CFCI', 'CFCI', 485, '2026-05-08', 'paid', '2026-05-08', 485, 'Pago - Curso para Corretores.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('876b0141-6fa4-448e-8d96-dd7253ea4c07', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'e336bfec-7aa8-4ce7-9e44-21f6286de1a7', 485, '2026-05-08', 'Pago - Curso para Corretores.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('8be1e4fd-ea7a-43ad-b1f9-61f603566245', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 485, '2026-05-08', 'Curso para Corretores — CFCI', 'e336bfec-7aa8-4ce7-9e44-21f6286de1a7', 'Pix', 'Pago - Curso para Corretores.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('a82ac23b-6862-4fe7-b4b7-c010edf0b7d4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — Jsmart e Diagonal', 'Meta', 1139, '2026-05-08', 'paid', '2026-05-08', 1139, 'Pago - Saldo Meta - Jsmart e Diagonal.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('bb985b00-31c0-4d79-9021-3901f8dac680', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'a82ac23b-6862-4fe7-b4b7-c010edf0b7d4', 1139, '2026-05-08', 'Pago - Saldo Meta - Jsmart e Diagonal.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('b7f2b111-993c-439b-80b5-794536b56bdc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-08', 'Saldo Meta — Jsmart e Diagonal', 'a82ac23b-6862-4fe7-b4b7-c010edf0b7d4', 'Pix', 'Pago - Saldo Meta - Jsmart e Diagonal.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('aa05bbdb-8e16-4275-8253-3408a1813468', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — MLar Cambeba e Lago', 'Meta', 1139, '2026-05-08', 'paid', '2026-05-08', 1139, 'Pago - Saldo Meta — MLar Cambeba e Lago');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b1fb3670-0fa7-42fe-bf6c-134398ea84aa', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'aa05bbdb-8e16-4275-8253-3408a1813468', 1139, '2026-05-08', 'Pago - Saldo Meta — MLar Cambeba e Lago');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('3815f2b5-8602-4361-9063-8f31896b47ef', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-08', 'Saldo Meta — MLar Cambeba e Lago', 'aa05bbdb-8e16-4275-8253-3408a1813468', 'Pix', 'Pago - Saldo Meta — MLar Cambeba e Lago');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('e3ffd6a8-76c9-469d-8b97-65ba5ebc475a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — BSWave e Maré', 'Meta', 1139, '2026-05-08', 'paid', '2026-05-08', 1139, 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d6c60d23-5b0f-4580-9628-e4caa7bbb0f3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'e3ffd6a8-76c9-469d-8b97-65ba5ebc475a', 1139, '2026-05-08', 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('e1845b66-8d5b-47b6-8222-20b82f3e3bf9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-08', 'Saldo Meta — BSWave e Maré', 'e3ffd6a8-76c9-469d-8b97-65ba5ebc475a', 'Pix', 'Pago - Saldo Meta - MLar Cambeba e Lago - Maio26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('dc428b94-6092-4343-a37c-9cde59010380', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Compra de 03 celulares', 'Bruno', 750, '2026-05-14', 'paid', '2026-05-14', 750, 'Pago - Celulares');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('9d4fd753-16f5-46bb-a079-479be52d956d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'dc428b94-6092-4343-a37c-9cde59010380', 750, '2026-05-14', 'Pago - Celulares');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('f153382a-78d4-4982-9490-1de45c6f65c6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 750, '2026-05-14', 'Compra de 03 celulares', 'dc428b94-6092-4343-a37c-9cde59010380', 'Pix', 'Pago - Celulares');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('3f61af4e-2572-480d-86ef-037e046dbbfe', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — MLar Cambeba e Lago', 'Meta', 1139, '2026-05-14', 'paid', '2026-05-14', 1139, 'Pago - Saldo Meta - Mlar Lago e Cambeba.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b6c2470f-11b9-4f4e-a90c-957677cd0e0f', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3f61af4e-2572-480d-86ef-037e046dbbfe', 1139, '2026-05-14', 'Pago - Saldo Meta - Mlar Lago e Cambeba.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('a40053d7-484d-4787-9ce1-3bd82d7ca8b5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-14', 'Saldo Meta — MLar Cambeba e Lago', '3f61af4e-2572-480d-86ef-037e046dbbfe', 'Pix', 'Pago - Saldo Meta - Mlar Lago e Cambeba.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ab21bcaf-22d2-4028-b48d-0037825eefe8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google — Fortaleza', 'Google', 1000, '2026-05-15', 'paid', '2026-05-15', 1000, 'Pago - Saldo Google — Fortaleza.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b4c83360-4aa6-42f8-ae8b-526284b57c07', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ab21bcaf-22d2-4028-b48d-0037825eefe8', 1000, '2026-05-15', 'Pago - Saldo Google — Fortaleza.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('e5c3252d-e347-4b27-895b-d7c7e9941165', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-15', 'Saldo Google — Fortaleza', 'ab21bcaf-22d2-4028-b48d-0037825eefe8', 'Pix', 'Pago - Saldo Google — Fortaleza.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('6691a90b-c8cb-49e9-8f90-803e6e599e94', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google — Imoveis Praia', 'Google', 600, '2026-05-15', 'paid', '2026-05-15', 600, 'Pago - Saldo Google — Imoveis Praia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('22c442b9-0439-4887-b40f-d9be5677ba57', 'e11042be-3d22-4048-9380-ac71e8dc9252', '6691a90b-c8cb-49e9-8f90-803e6e599e94', 600, '2026-05-15', 'Pago - Saldo Google — Imoveis Praia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('52073590-3807-40aa-9f1e-d02a86c9406c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 600, '2026-05-15', 'Saldo Google — Imoveis Praia', '6691a90b-c8cb-49e9-8f90-803e6e599e94', 'Pix', 'Pago - Saldo Google — Imoveis Praia.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('58f5ecf1-014e-4590-9661-d321e9cb2fb0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Placas do escritório', 'CE Placas', 375, '2026-05-15', 'paid', '2026-05-15', 375, 'Pago - Placas Escritório');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('06e9f1a8-92ad-4d2d-88ed-026ec10ae04e', 'e11042be-3d22-4048-9380-ac71e8dc9252', '58f5ecf1-014e-4590-9661-d321e9cb2fb0', 375, '2026-05-15', 'Pago - Placas Escritório');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('513d9bfd-0cb1-41fd-be74-9676fc08feee', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 375, '2026-05-15', 'Placas do escritório', '58f5ecf1-014e-4590-9661-d321e9cb2fb0', 'Pix', 'Pago - Placas Escritório');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ff138fc6-65b6-4a43-82e9-64142737ceb5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google — Outros Estados', 'Google', 500, '2026-05-15', 'paid', '2026-05-15', 500, 'Pago - Saldo Google — Outro Estados.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('1268ca46-92d8-4b55-bae3-f1319fcf89e7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ff138fc6-65b6-4a43-82e9-64142737ceb5', 500, '2026-05-15', 'Pago - Saldo Google — Outro Estados.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('5cb3111d-3b66-4794-b07a-1ee58415c462', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-15', 'Saldo Google — Outros Estados', 'ff138fc6-65b6-4a43-82e9-64142737ceb5', 'Pix', 'Pago - Saldo Google — Outro Estados.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('d7d774f0-a290-4505-a5d4-eccc630fa84b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno - Bella Aldeota (Mateus)', 'Reno', 5400.47, '2026-05-18', 'paid', '2026-05-18', 5400.47, 'Pago - Comissão Reno - Bella Aldeota');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('1d9e5ed7-ce98-4b06-8762-be3670c19e64', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'd7d774f0-a290-4505-a5d4-eccc630fa84b', 5400.47, '2026-05-18', 'Pago - Comissão Reno - Bella Aldeota');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('17994a53-f718-42b3-affe-177408910ec5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 5400.47, '2026-05-18', 'Comissão Reno - Bella Aldeota (Mateus)', 'd7d774f0-a290-4505-a5d4-eccc630fa84b', 'Pix', 'Pago - Comissão Reno - Bella Aldeota');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('e3008849-a1eb-4d20-a7d4-748ebd8ab931', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — BSWave e Maré', 'Meta', 1139, '2026-05-18', 'paid', '2026-05-18', 1139, 'Pago - Nota Fiscal - Saldo Meta — BSWave e Maré - 18052026.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('56c9e676-9299-419b-8f82-61dfbf340db8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'e3008849-a1eb-4d20-a7d4-748ebd8ab931', 1139, '2026-05-18', 'Pago - Nota Fiscal - Saldo Meta — BSWave e Maré - 18052026.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('5e14972b-ccd6-42ae-b442-ddace1214cd8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-18', 'Saldo Meta — BSWave e Maré', 'e3008849-a1eb-4d20-a7d4-748ebd8ab931', 'Pix', 'Pago - Nota Fiscal - Saldo Meta — BSWave e Maré - 18052026.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('58aa5e0a-9da4-4c09-a287-7c0104f1a536', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angelica - Bella Aldeota (Mateus)', 'Angélica', 500, '2026-05-18', 'paid', '2026-05-18', 500, 'Pago - Nota Fiscal - Comissão Bella Aldeota - Mateus.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('bcfea194-6de6-4b1b-9629-15f736407f8f', 'e11042be-3d22-4048-9380-ac71e8dc9252', '58aa5e0a-9da4-4c09-a287-7c0104f1a536', 500, '2026-05-18', 'Pago - Nota Fiscal - Comissão Bella Aldeota - Mateus.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('b8870250-c886-486b-95b6-befff65283b5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-18', 'Comissão Angelica - Bella Aldeota (Mateus)', '58aa5e0a-9da4-4c09-a287-7c0104f1a536', 'Pix', 'Pago - Nota Fiscal - Comissão Bella Aldeota - Mateus.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('8fc96cbe-3200-46b1-b335-652329521bdf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bônus Reno - Bella Aldeota (Mateus)', 'Reno', 1495.28, '2026-05-18', 'paid', '2026-05-18', 1495.28, 'Pago - Bônus  Bella Aldeota -  Reno');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('0f385f47-61f9-4ad7-8a55-aaae20e7e878', 'e11042be-3d22-4048-9380-ac71e8dc9252', '8fc96cbe-3200-46b1-b335-652329521bdf', 1495.28, '2026-05-18', 'Pago - Bônus  Bella Aldeota -  Reno');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('fdc4547e-f628-4797-93b8-1ec60db4449d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1495.28, '2026-05-18', 'Bônus Reno - Bella Aldeota (Mateus)', '8fc96cbe-3200-46b1-b335-652329521bdf', 'Pix', 'Pago - Bônus  Bella Aldeota -  Reno');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('83df3556-bca2-4fe3-b729-51378bc00e06', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - MLar Cambeba e Lago', 'Meta', 1139, '2026-05-20', 'paid', '2026-05-20', 1139, 'Pago - Nota Fiscal - Mlar Lago e Cambeba.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('e68a615b-56a8-49a7-bf5c-81907b99ea80', 'e11042be-3d22-4048-9380-ac71e8dc9252', '83df3556-bca2-4fe3-b729-51378bc00e06', 1139, '2026-05-20', 'Pago - Nota Fiscal - Mlar Lago e Cambeba.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('e9381082-7782-49dc-b53d-557209e86116', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-05-20', 'Saldo Meta - MLar Cambeba e Lago', '83df3556-bca2-4fe3-b729-51378bc00e06', 'Pix', 'Pago - Nota Fiscal - Mlar Lago e Cambeba.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ead5273a-4656-4117-abf5-e0aab29175b9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - La Vie e Inc Parquelandia', 'Meta', 800, '2026-05-22', 'paid', '2026-05-22', 800, 'Pago - Saldo Meta - La Vie e Inc Parquelandia');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('87de38d7-d923-4c0e-8e1d-a39683dabfe4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ead5273a-4656-4117-abf5-e0aab29175b9', 800, '2026-05-22', 'Pago - Saldo Meta - La Vie e Inc Parquelandia');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('79eec0ca-3e55-4330-a535-fd4d3c8a4247', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 800, '2026-05-22', 'Saldo Meta - La Vie e Inc Parquelandia', 'ead5273a-4656-4117-abf5-e0aab29175b9', 'Pix', 'Pago - Saldo Meta - La Vie e Inc Parquelandia');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('cd7d4da5-9eff-4648-842c-417036dfc496', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angelica - Maré - Beatriz', 'Angélica', 500, '2026-05-22', 'paid', '2026-05-22', 500, 'Pago - Nota Fiscal - Comissão Angélica.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b30a3deb-7a04-40e0-b241-0d2ce556b3bd', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'cd7d4da5-9eff-4648-842c-417036dfc496', 500, '2026-05-22', 'Pago - Nota Fiscal - Comissão Angélica.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('1dc4654d-5379-4b16-84ad-5a86a8090c1e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-22', 'Comissão Angelica - Maré - Beatriz', 'cd7d4da5-9eff-4648-842c-417036dfc496', 'Pix', 'Pago - Nota Fiscal - Comissão Angélica.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('366f50c4-3623-468c-8c28-06bb71e75fc5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Felipe- Maré - Beatriz', 'Felipe', 250, '2026-05-24', 'paid', '2026-05-24', 250, 'Pago- Nota Fiscal - Comissão Felipe.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('204aebdc-e29d-4078-9695-710b80c4a5e1', 'e11042be-3d22-4048-9380-ac71e8dc9252', '366f50c4-3623-468c-8c28-06bb71e75fc5', 250, '2026-05-24', 'Pago- Nota Fiscal - Comissão Felipe.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('2de27e44-fbb3-4f08-9edb-72dc9cd88029', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 250, '2026-05-24', 'Comissão Felipe- Maré - Beatriz', '366f50c4-3623-468c-8c28-06bb71e75fc5', 'Pix', 'Pago- Nota Fiscal - Comissão Felipe.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('2baf4f54-400a-4059-86ab-0c2512da12c6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Pedro- Maré - Beatriz', 'Pedro', 250, '2026-05-24', 'paid', '2026-05-24', 250, 'Nota Fiscal - Comissão Pedro.PDF');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('14a54385-2e2a-49c0-a8e9-2e47fc4826bd', 'e11042be-3d22-4048-9380-ac71e8dc9252', '2baf4f54-400a-4059-86ab-0c2512da12c6', 250, '2026-05-24', 'Nota Fiscal - Comissão Pedro.PDF');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('fc50305d-36bb-40db-941f-cd3be26d025b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 250, '2026-05-24', 'Comissão Pedro- Maré - Beatriz', '2baf4f54-400a-4059-86ab-0c2512da12c6', 'Pix', 'Nota Fiscal - Comissão Pedro.PDF');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('c0d66e5f-75bd-48db-afc5-f26a61f245b0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico/Orizon/Seano', 'Meta', 1000, '2026-05-27', 'paid', '2026-05-27', 1000, 'Pago - Saldo Meta - Atlântico/Orizon/Seano - 27/05');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('8a89f83a-b6ef-45df-afed-abe5a734553f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c0d66e5f-75bd-48db-afc5-f26a61f245b0', 1000, '2026-05-27', 'Pago - Saldo Meta - Atlântico/Orizon/Seano - 27/05');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('5693aa9c-d70b-4397-916b-d292e5b86800', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-27', 'Saldo Meta - Atlântico/Orizon/Seano', 'c0d66e5f-75bd-48db-afc5-f26a61f245b0', 'Pix', 'Pago - Saldo Meta - Atlântico/Orizon/Seano - 27/05');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('cfe4ca39-fdd7-40b0-8908-fe4fbe6003d7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Mlar Cambeba / Lago', 'Meta', 1000, '2026-05-27', 'paid', '2026-05-27', 1000, 'Pago - Saldo Meta - Mlar lago/cambeba - 27/05');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b20494bd-c51f-497a-8a30-a5710ae3c476', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'cfe4ca39-fdd7-40b0-8908-fe4fbe6003d7', 1000, '2026-05-27', 'Pago - Saldo Meta - Mlar lago/cambeba - 27/05');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('9fc2a417-b50c-4b32-a15d-08e32a37ac12', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-27', 'Saldo Meta - Mlar Cambeba / Lago', 'cfe4ca39-fdd7-40b0-8908-fe4fbe6003d7', 'Pix', 'Pago - Saldo Meta - Mlar lago/cambeba - 27/05');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('5f6006d5-308e-48bf-b4c9-1476c1bbf017', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob Fortaleza', 'Google', 1000, '2026-05-27', 'paid', '2026-05-27', 1000, 'Pago - Saldo Googld - Re9 Imob Fortaleza - 27/05');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('db52f222-de07-4bab-8429-1affd796c131', 'e11042be-3d22-4048-9380-ac71e8dc9252', '5f6006d5-308e-48bf-b4c9-1476c1bbf017', 1000, '2026-05-27', 'Pago - Saldo Googld - Re9 Imob Fortaleza - 27/05');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('3e9ad4f4-9428-4955-8964-8808e7347c5f', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-27', 'Saldo Google - Re9 Imob Fortaleza', '5f6006d5-308e-48bf-b4c9-1476c1bbf017', 'Pix', 'Pago - Saldo Googld - Re9 Imob Fortaleza - 27/05');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ea7021d4-af13-40cb-a777-cceb42fdaadf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Salário Angélica', 'Angélica', 2500, '2026-05-27', 'paid', '2026-05-27', 2500, 'Pago - Nota Fiscal - Salário - Angélica.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('c9668b00-e56b-422f-94a3-b636c7acd4d5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ea7021d4-af13-40cb-a777-cceb42fdaadf', 2500, '2026-05-27', 'Pago - Nota Fiscal - Salário - Angélica.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('31cae919-6c10-41ec-b8a5-d34655c62291', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2500, '2026-05-27', 'Salário Angélica', 'ea7021d4-af13-40cb-a777-cceb42fdaadf', 'Pix', 'Pago - Nota Fiscal - Salário - Angélica.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('849d0111-1cfa-48cc-b317-d70eda165302', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico/Orizon/Seano', 'Meta', 1000, '2026-05-29', 'paid', '2026-05-29', 1000, 'Pago - Saldo Meta - AtlanticoSeanoOrizon 3 - Maio26.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('31de9023-6afd-4fde-bf13-87b5b5a339c6', 'e11042be-3d22-4048-9380-ac71e8dc9252', '849d0111-1cfa-48cc-b317-d70eda165302', 1000, '2026-05-29', 'Pago - Saldo Meta - AtlanticoSeanoOrizon 3 - Maio26.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('02705123-2332-4edb-b2c8-6ea4004d7f69', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-05-29', 'Saldo Meta - Atlântico/Orizon/Seano', '849d0111-1cfa-48cc-b317-d70eda165302', 'Pix', 'Pago - Saldo Meta - AtlanticoSeanoOrizon 3 - Maio26.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('238ca88e-2086-43b3-886b-28c90e83281d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - BSWave e Maré', 'Meta', 500, '2026-05-29', 'paid', '2026-05-29', 500, 'Pago - Saldo Meta - BSWave e Mare - Maio26 2.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('485592b7-282f-4cb1-bc40-ab4fa99e3bb0', 'e11042be-3d22-4048-9380-ac71e8dc9252', '238ca88e-2086-43b3-886b-28c90e83281d', 500, '2026-05-29', 'Pago - Saldo Meta - BSWave e Mare - Maio26 2.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('51724abf-f392-41f3-8a83-a4cc45bd5ab0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-05-29', 'Saldo Meta - BSWave e Maré', '238ca88e-2086-43b3-886b-28c90e83281d', 'Pix', 'Pago - Saldo Meta - BSWave e Mare - Maio26 2.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ad0d1c89-3f49-4b2a-8459-40a1f09db2ee', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno - Bella Aldeota (Mateus)', 'Reno', 13623.4, '2026-06-01', 'paid', '2026-06-01', 13623.4, 'Pago - Comissão Reno.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5f2b8065-9b35-4c9f-9bd6-6813b6f891dd', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ad0d1c89-3f49-4b2a-8459-40a1f09db2ee', 13623.4, '2026-06-01', 'Pago - Comissão Reno.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('9541bdcb-6711-40f2-b777-59a8769c2560', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 13623.4, '2026-06-01', 'Comissão Reno - Bella Aldeota (Mateus)', 'ad0d1c89-3f49-4b2a-8459-40a1f09db2ee', 'Pix', 'Pago - Comissão Reno.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('65a7ed95-d2fc-4728-9ec6-de04f0711e5a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico/Orizon/Seano', 'Meta', 1139, '2026-06-02', 'paid', '2026-06-02', 1139, 'Pago - Atlântico  Orizon  Seano  Inc Cambeba.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('288df7e8-19e1-4802-9b34-e4d3e1bfac3d', 'e11042be-3d22-4048-9380-ac71e8dc9252', '65a7ed95-d2fc-4728-9ec6-de04f0711e5a', 1139, '2026-06-02', 'Pago - Atlântico  Orizon  Seano  Inc Cambeba.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('18fb43cc-5a33-4b72-af99-a15518bc6cc7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1139, '2026-06-02', 'Saldo Meta - Atlântico/Orizon/Seano', '65a7ed95-d2fc-4728-9ec6-de04f0711e5a', 'Pix', 'Pago - Atlântico  Orizon  Seano  Inc Cambeba.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('9334610e-4cd0-469c-b9e1-dd271498b224', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta — BSWave e Maré', 'Meta', 570, '2026-06-02', 'paid', '2026-06-02', 570, 'Pago - BS Wave  Maré.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5958d2db-82f9-4c82-be08-1662a47fa852', 'e11042be-3d22-4048-9380-ac71e8dc9252', '9334610e-4cd0-469c-b9e1-dd271498b224', 570, '2026-06-02', 'Pago - BS Wave  Maré.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('13fd83b8-44da-4245-9359-8f978184ee51', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 570, '2026-06-02', 'Saldo Meta — BSWave e Maré', '9334610e-4cd0-469c-b9e1-dd271498b224', 'Pix', 'Pago - BS Wave  Maré.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('f459bb34-98d3-414f-b003-3a9c8eceb049', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Mlar Cambeba / Lago', 'Meta', 570, '2026-06-02', 'paid', '2026-06-02', 570, 'Pago - MLar Cambeba  MLar Lago.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('c50ef9e9-d5ed-4588-985a-30eb30ca2a1e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f459bb34-98d3-414f-b003-3a9c8eceb049', 570, '2026-06-02', 'Pago - MLar Cambeba  MLar Lago.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('e314e5bd-2317-4535-9965-9a43459ef6bf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 570, '2026-06-02', 'Saldo Meta - Mlar Cambeba / Lago', 'f459bb34-98d3-414f-b003-3a9c8eceb049', 'Pix', 'Pago - MLar Cambeba  MLar Lago.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('6f08b218-e673-4f67-abaf-f28bcb81d99e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Imóveis Praia', 'Google', 500, '2026-06-04', 'paid', '2026-06-04', 500, 'Pgto Google - RE9Imob Imoveis Praia - Jun26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('0de622f5-91c4-4498-9c9a-65fae9e3adc4', 'e11042be-3d22-4048-9380-ac71e8dc9252', '6f08b218-e673-4f67-abaf-f28bcb81d99e', 500, '2026-06-04', 'Pgto Google - RE9Imob Imoveis Praia - Jun26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('d20e9158-93d4-44de-b220-260ab5d1927c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-04', 'Saldo Google - RE9 Imob - Imóveis Praia', '6f08b218-e673-4f67-abaf-f28bcb81d99e', 'Pix', 'Pgto Google - RE9Imob Imoveis Praia - Jun26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('706217b4-cc55-417f-bccd-18f9e8d3aa25', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Internacional', 'Google', 500, '2026-06-04', 'paid', '2026-06-04', 500, 'Pgto Google - RE9Imob Internacional - Jun26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d189a1f1-945d-4620-b7d4-4b667c01ab28', 'e11042be-3d22-4048-9380-ac71e8dc9252', '706217b4-cc55-417f-bccd-18f9e8d3aa25', 500, '2026-06-04', 'Pgto Google - RE9Imob Internacional - Jun26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('6ae3d44f-9949-434b-a184-a2802cdf90df', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-04', 'Saldo Google - RE9 Imob - Internacional', '706217b4-cc55-417f-bccd-18f9e8d3aa25', 'Pix', 'Pgto Google - RE9Imob Internacional - Jun26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('187ae54b-c527-45d3-9b1e-69d2ed272495', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico / Orizon / Seano / IncCambeba', 'Meta', 500, '2026-06-04', 'paid', '2026-06-04', 500, 'Pgto Meta - Atlantico, Orizon, Seano, Inc Cambeba.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('08ccd88c-c057-4143-9e11-36944c399d73', 'e11042be-3d22-4048-9380-ac71e8dc9252', '187ae54b-c527-45d3-9b1e-69d2ed272495', 500, '2026-06-04', 'Pgto Meta - Atlantico, Orizon, Seano, Inc Cambeba.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('8e90e650-5787-4b9c-8f56-e8dd3ecb44b4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-04', 'Saldo Meta - Atlântico / Orizon / Seano / IncCambeba', '187ae54b-c527-45d3-9b1e-69d2ed272495', 'Pix', 'Pgto Meta - Atlantico, Orizon, Seano, Inc Cambeba.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('b7165f3b-1fa7-46d4-ae48-f5040b94c7a4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Bella Aldeota / Bella Rio / BS Rubi', 'Meta', 1000, '2026-06-04', 'paid', '2026-06-04', 1000, 'Pgto Meta - Bella Aldeota, Bella Rio, BS Rubi.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('4684095c-f983-49b2-979f-561a4ebc3ab5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'b7165f3b-1fa7-46d4-ae48-f5040b94c7a4', 1000, '2026-06-04', 'Pgto Meta - Bella Aldeota, Bella Rio, BS Rubi.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('fe6fb6fd-7c05-4e1f-b1b8-0ccea5dbfae1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-04', 'Saldo Meta - Bella Aldeota / Bella Rio / BS Rubi', 'b7165f3b-1fa7-46d4-ae48-f5040b94c7a4', 'Pix', 'Pgto Meta - Bella Aldeota, Bella Rio, BS Rubi.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('c3f76aa7-be9c-40b8-bf06-c45e4f1b6d9d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - BSWave / Maré / BC Cumbuco / VistaCoqueiral', 'Meta', 500, '2026-06-04', 'paid', '2026-06-04', 500, 'Pgto Meta - BS Wave, Maré, BC Cumbuco, Vista Coqueiral.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('e035d48f-ab1e-4e49-a4f1-02b2ccd49829', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c3f76aa7-be9c-40b8-bf06-c45e4f1b6d9d', 500, '2026-06-04', 'Pgto Meta - BS Wave, Maré, BC Cumbuco, Vista Coqueiral.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('555cb0a1-6c80-484e-823f-bbc6b56902b6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-04', 'Saldo Meta - BSWave / Maré / BC Cumbuco / VistaCoqueiral', 'c3f76aa7-be9c-40b8-bf06-c45e4f1b6d9d', 'Pix', 'Pgto Meta - BS Wave, Maré, BC Cumbuco, Vista Coqueiral.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('d76c7a17-0352-4fb4-9436-d23eedd5c552', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Mlar Cambeba / Lago', 'Meta', 500, '2026-06-04', 'paid', '2026-06-04', 500, 'Pgto Meta - MLar Cameba, MLar Lago.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('bbe00887-8494-4b0c-804b-b594e5d261b4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'd76c7a17-0352-4fb4-9436-d23eedd5c552', 500, '2026-06-04', 'Pgto Meta - MLar Cameba, MLar Lago.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('58b6a3d6-6fd2-4ef0-a471-139ea78cc82c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-04', 'Saldo Meta - Mlar Cambeba / Lago', 'd76c7a17-0352-4fb4-9436-d23eedd5c552', 'Pix', 'Pgto Meta - MLar Cameba, MLar Lago.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('15da9417-bd1e-48e3-bed7-c95d917e6b94', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - La Vie / Inc Parquelandia', 'Meta', 300, '2026-06-04', 'paid', '2026-06-04', 300, 'Pgto Meta - La Vie, Inc Parquelandia.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('554abf73-e54b-4f36-a1cd-13b8cb714b96', 'e11042be-3d22-4048-9380-ac71e8dc9252', '15da9417-bd1e-48e3-bed7-c95d917e6b94', 300, '2026-06-04', 'Pgto Meta - La Vie, Inc Parquelandia.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('d469fef2-c4a9-4238-b63b-066d8e634c1e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-06-04', 'Saldo Meta - La Vie / Inc Parquelandia', '15da9417-bd1e-48e3-bed7-c95d917e6b94', 'Pix', 'Pgto Meta - La Vie, Inc Parquelandia.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('54cae0d7-cb46-4b80-b259-128c14776977', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Fortaleza', 'Google', 1000, '2026-06-04', 'paid', '2026-06-04', 1000, 'Pgto Google - RE9Imob Fortaleza - Jun26.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('a65640d4-586d-492c-a4fe-30c8444fd678', 'e11042be-3d22-4048-9380-ac71e8dc9252', '54cae0d7-cb46-4b80-b259-128c14776977', 1000, '2026-06-04', 'Pgto Google - RE9Imob Fortaleza - Jun26.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('1493bff1-9512-4921-9060-5549db7ef6cc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-04', 'Saldo Google - RE9 Imob - Fortaleza', '54cae0d7-cb46-4b80-b259-128c14776977', 'Pix', 'Pgto Google - RE9Imob Fortaleza - Jun26.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('f41ba79a-d799-4658-a6fe-678a665bc401', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Contabilidade', 'Souza', 300, '2026-06-10', 'paid', '2026-06-10', 300, 'Pago - Contabilidade.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5fcf516b-eea3-4648-a900-001ad5d6c990', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f41ba79a-d799-4658-a6fe-678a665bc401', 300, '2026-06-10', 'Pago - Contabilidade.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('deccebea-417f-4679-916e-7bd2c85e0ccc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-06-10', 'Comissão Contabilidade', 'f41ba79a-d799-4658-a6fe-678a665bc401', 'Pix', 'Pago - Contabilidade.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('156f1607-5193-40a7-bff2-bae5c5312388', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Imposto Maio/26', 'Receita Federal', 4700.39, '2026-06-11', 'paid', '2026-06-11', 4700.39, 'Pago - Impostos.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('4b3c9007-1057-4ad4-9ca6-ebac728745c7', 'e11042be-3d22-4048-9380-ac71e8dc9252', '156f1607-5193-40a7-bff2-bae5c5312388', 4700.39, '2026-06-11', 'Pago - Impostos.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('da678fdb-9274-486b-bbdd-bf02d029cf92', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 4700.39, '2026-06-11', 'Imposto Maio/26', '156f1607-5193-40a7-bff2-bae5c5312388', 'Pix', 'Pago - Impostos.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('9c827a26-7458-4a53-9cd9-f8fd42cafc66', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Salário Angélica', 'Angélica', 2500, '2026-06-18', 'paid', '2026-06-18', 2500, 'Pago - Salário Angélica.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('0b423f77-7f04-4395-84b2-9e390fb6df8f', 'e11042be-3d22-4048-9380-ac71e8dc9252', '9c827a26-7458-4a53-9cd9-f8fd42cafc66', 2500, '2026-06-18', 'Pago - Salário Angélica.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('439b8782-de4b-4e24-8c45-f33ba06b7e73', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2500, '2026-06-18', 'Salário Angélica', '9c827a26-7458-4a53-9cd9-f8fd42cafc66', 'Pix', 'Pago - Salário Angélica.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('70cc0ee5-9aff-451c-af6e-728325293e05', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pgto Google RE9 Imob - Fortaleza', 'Google', 1000, '2026-06-18', 'paid', '2026-06-18', 1000, 'Pago - Salário Angélica.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2239496c-b60f-45b8-8d0f-9b97410a2158', 'e11042be-3d22-4048-9380-ac71e8dc9252', '70cc0ee5-9aff-451c-af6e-728325293e05', 1000, '2026-06-18', 'Pago - Salário Angélica.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('130ccf53-44f4-4b67-862e-7ba8eb6198d5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-18', 'Pgto Google RE9 Imob - Fortaleza', '70cc0ee5-9aff-451c-af6e-728325293e05', 'Pix', 'Pago - Salário Angélica.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('c150c083-2f21-4ae4-b322-ca925d994225', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pgto Google RE9 Imob - Imóveis Praia', 'Google', 400, '2026-06-18', 'paid', '2026-06-18', 400, 'Pago - Google RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('8b0f81ee-70d8-491b-b140-a681bde43ed2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c150c083-2f21-4ae4-b322-ca925d994225', 400, '2026-06-18', 'Pago - Google RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('51338e6f-b83c-4ee5-802c-f966b8cf48f7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-06-18', 'Pgto Google RE9 Imob - Imóveis Praia', 'c150c083-2f21-4ae4-b322-ca925d994225', 'Pix', 'Pago - Google RE9 Imob - Imóveis Praia.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('8fa803a3-5587-444a-bc42-b1c21e40a532', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pgto Google RE9 Imob - Outros Estados', 'Google', 500, '2026-06-18', 'paid', '2026-06-18', 500, 'Pago - Google RE9 Imob - Outros Estados.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5f23a8e1-04e0-470c-b5cd-3fe010b7319b', 'e11042be-3d22-4048-9380-ac71e8dc9252', '8fa803a3-5587-444a-bc42-b1c21e40a532', 500, '2026-06-18', 'Pago - Google RE9 Imob - Outros Estados.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('9ba84d10-b8cd-4fb9-b851-7b93fe904cab', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-18', 'Pgto Google RE9 Imob - Outros Estados', '8fa803a3-5587-444a-bc42-b1c21e40a532', 'Pix', 'Pago - Google RE9 Imob - Outros Estados.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('2a5d0c52-2d8a-4648-9c67-d8442645a4f5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pgto Google RE9 Imob - Internacional', 'Google', 300, '2026-06-18', 'paid', '2026-06-18', 300, 'Pago - Google RE9 Imob - Internacional.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2806f341-b025-47b7-9e92-099eece07cbc', 'e11042be-3d22-4048-9380-ac71e8dc9252', '2a5d0c52-2d8a-4648-9c67-d8442645a4f5', 300, '2026-06-18', 'Pago - Google RE9 Imob - Internacional.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('5ddff779-e920-4a38-8e28-cff69ab1628a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-06-18', 'Pgto Google RE9 Imob - Internacional', '2a5d0c52-2d8a-4648-9c67-d8442645a4f5', 'Pix', 'Pago - Google RE9 Imob - Internacional.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('c2061c31-9ece-4843-8cbe-6de5883f2046', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno - MLar Kennedy (Lia e Jonathan)', 'Reno', 7466.78, '2026-06-18', 'paid', '2026-06-18', 7466.78, 'Pago - Comissao Reno MLar Kennedy Lia e Jonathan.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('65e0a528-bef6-4f9e-8e91-d34e9b75b8f7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c2061c31-9ece-4843-8cbe-6de5883f2046', 7466.78, '2026-06-18', 'Pago - Comissao Reno MLar Kennedy Lia e Jonathan.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('950de599-50c6-449b-9036-1f0be8c6cf99', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 7466.78, '2026-06-18', 'Comissão Reno - MLar Kennedy (Lia e Jonathan)', 'c2061c31-9ece-4843-8cbe-6de5883f2046', 'Pix', 'Pago - Comissao Reno MLar Kennedy Lia e Jonathan.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('a9dd16c4-2d41-4ec3-b5d1-271c7331d3f2', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico  Orizon  Seano  Inc Cambeba', 'Meta', 1000, '2026-06-19', 'paid', '2026-06-19', 1000, 'Pago -Saldo Meta - Atlântico  Orizon  Seano  Inc Cambeba.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('f19536a5-96c3-41a5-b5aa-b6bbb75cdeaf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'a9dd16c4-2d41-4ec3-b5d1-271c7331d3f2', 1000, '2026-06-19', 'Pago -Saldo Meta - Atlântico  Orizon  Seano  Inc Cambeba.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('6e72315d-40a9-44a3-ab52-5cf94863cc22', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-19', 'Saldo Meta - Atlântico  Orizon  Seano  Inc Cambeba', 'a9dd16c4-2d41-4ec3-b5d1-271c7331d3f2', 'Pix', 'Pago -Saldo Meta - Atlântico  Orizon  Seano  Inc Cambeba.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('22fb7707-cdea-4eff-a6f0-a44ab49972bb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angélica', 'Angélica', 500, '2026-06-19', 'paid', '2026-06-19', 500, 'Comissão Angélica.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2d3c1d7d-76fd-4a74-bc24-91bc24b4a789', 'e11042be-3d22-4048-9380-ac71e8dc9252', '22fb7707-cdea-4eff-a6f0-a44ab49972bb', 500, '2026-06-19', 'Comissão Angélica.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('8d40415f-c3ec-48b4-97bc-3ce847f350be', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-19', 'Comissão Angélica', '22fb7707-cdea-4eff-a6f0-a44ab49972bb', 'Pix', 'Comissão Angélica.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('5adf14c4-7702-4265-b68d-845654257f31', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Felipe', 'Felipe', 250, '2026-06-19', 'paid', '2026-06-19', 250, 'Comissão Felipe.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('7aa29579-5810-4c76-9162-41929f270f40', 'e11042be-3d22-4048-9380-ac71e8dc9252', '5adf14c4-7702-4265-b68d-845654257f31', 250, '2026-06-19', 'Comissão Felipe.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('20587d47-c7a0-411c-ba54-71f414d494c7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 250, '2026-06-19', 'Comissão Felipe', '5adf14c4-7702-4265-b68d-845654257f31', 'Pix', 'Comissão Felipe.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('7d153d0a-96ef-4d06-8eee-3efbba700daa', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Bella Aldeota Bella Rio  BS Rubi', 'Meta', 1000, '2026-06-19', 'paid', '2026-06-19', 1000, 'Pago - Saldo Meta - Bella Aldeota Bella Rio  BS Rubi.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5f0e9251-2e01-481b-bf8b-22f44efd6272', 'e11042be-3d22-4048-9380-ac71e8dc9252', '7d153d0a-96ef-4d06-8eee-3efbba700daa', 1000, '2026-06-19', 'Pago - Saldo Meta - Bella Aldeota Bella Rio  BS Rubi.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('306b488b-f284-46f3-b966-ef6a379f6a82', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-19', 'Saldo Meta - Bella Aldeota Bella Rio  BS Rubi', '7d153d0a-96ef-4d06-8eee-3efbba700daa', 'Pix', 'Pago - Saldo Meta - Bella Aldeota Bella Rio  BS Rubi.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('080cd0d1-9db1-4a12-8c13-26e6cf56dbad', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - BSWave  Maré  BC Cumbuco  Vista Coqueiral', 'Meta', 1000, '2026-06-19', 'paid', '2026-06-19', 1000, 'Saldo Meta - BSWave  Maré  BC Cumbuco  Vista Coqueiral.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('4638ae42-9211-43dd-9a0b-21afd80b70ef', 'e11042be-3d22-4048-9380-ac71e8dc9252', '080cd0d1-9db1-4a12-8c13-26e6cf56dbad', 1000, '2026-06-19', 'Saldo Meta - BSWave  Maré  BC Cumbuco  Vista Coqueiral.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('f7c2793a-e2fe-48f7-8579-bb79e0bea081', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-19', 'Saldo Meta - BSWave  Maré  BC Cumbuco  Vista Coqueiral', '080cd0d1-9db1-4a12-8c13-26e6cf56dbad', 'Pix', 'Saldo Meta - BSWave  Maré  BC Cumbuco  Vista Coqueiral.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('61e21784-404e-40dc-b05f-fe1cb9f21748', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - MLar Cambeba  MLar Lago', 'Meta', 1000, '2026-06-19', 'paid', '2026-06-19', 1000, 'Saldo Meta - MLar Cambeba  MLar Lago.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('61b34c28-00e1-42ff-8c13-00d33a1402ef', 'e11042be-3d22-4048-9380-ac71e8dc9252', '61e21784-404e-40dc-b05f-fe1cb9f21748', 1000, '2026-06-19', 'Saldo Meta - MLar Cambeba  MLar Lago.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('1346f4ac-0a6a-4a44-af0b-bcee8577aa28', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-19', 'Saldo Meta - MLar Cambeba  MLar Lago', '61e21784-404e-40dc-b05f-fe1cb9f21748', 'Pix', 'Saldo Meta - MLar Cambeba  MLar Lago.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('31ecfa6a-b868-4087-90c3-c530761ae688', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - La Vie  Inc Parquelândia', 'Meta', 1000, '2026-06-19', 'paid', '2026-06-19', 1000, 'Saldo Meta - La Vie  Inc Parquelândia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('e19bcd59-f4df-4e9c-a3d6-0dbddb20ed11', 'e11042be-3d22-4048-9380-ac71e8dc9252', '31ecfa6a-b868-4087-90c3-c530761ae688', 1000, '2026-06-19', 'Saldo Meta - La Vie  Inc Parquelândia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('a7436d91-90fa-4596-b1f7-fda29889150a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-19', 'Saldo Meta - La Vie  Inc Parquelândia', '31ecfa6a-b868-4087-90c3-c530761ae688', 'Pix', 'Saldo Meta - La Vie  Inc Parquelândia.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('2e3af317-d5a0-4ba0-97c1-835692e14133', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Pedro', 'Pedro', 250, '2026-06-22', 'paid', '2026-06-22', 250, 'Comissão Pedro.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5b687921-5e5e-4543-86e6-8a64ed10f14f', 'e11042be-3d22-4048-9380-ac71e8dc9252', '2e3af317-d5a0-4ba0-97c1-835692e14133', 250, '2026-06-22', 'Comissão Pedro.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('a41ea160-8092-4f93-a09e-ed9ae7d3f766', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 250, '2026-06-22', 'Comissão Pedro', '2e3af317-d5a0-4ba0-97c1-835692e14133', 'Pix', 'Comissão Pedro.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('92b6bb7f-0ac2-42b0-bcb0-335b6b6194e9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pgto Saldo Google - RE9 Imob - Interior', 'Google', 50, '2026-06-22', 'paid', '2026-06-22', 50, 'Pgto Saldo Google - RE9 Imob - Interior.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('85d21512-2ea4-4602-9f9e-88581410ca46', 'e11042be-3d22-4048-9380-ac71e8dc9252', '92b6bb7f-0ac2-42b0-bcb0-335b6b6194e9', 50, '2026-06-22', 'Pgto Saldo Google - RE9 Imob - Interior.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('ae0b61a0-7ad2-43af-8cf6-edf5f8cfa970', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 50, '2026-06-22', 'Pgto Saldo Google - RE9 Imob - Interior', '92b6bb7f-0ac2-42b0-bcb0-335b6b6194e9', 'Pix', 'Pgto Saldo Google - RE9 Imob - Interior.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ebcc6107-75bd-4a18-ab8f-c30f9332c869', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Interior', 'Google', 500, '2026-06-23', 'paid', '2026-06-23', 500, 'Saldo Google - RE9 Imob - Interior.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('73c66271-a7c6-4c16-af77-3f4a001307d4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ebcc6107-75bd-4a18-ab8f-c30f9332c869', 500, '2026-06-23', 'Saldo Google - RE9 Imob - Interior.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('e951971a-a1a6-403c-90cf-ade900b76dd7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-23', 'Saldo Google - RE9 Imob - Interior', 'ebcc6107-75bd-4a18-ab8f-c30f9332c869', 'Pix', 'Saldo Google - RE9 Imob - Interior.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('10481020-ffbc-4890-982f-4c5bb49b2f68', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Fortaleza', 'Google', 1000, '2026-06-23', 'paid', '2026-06-23', 1000, 'Saldo Google - RE9 Imob - Fortaleza.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('a73a6bf8-e22d-4260-9a3c-e08aa3326534', 'e11042be-3d22-4048-9380-ac71e8dc9252', '10481020-ffbc-4890-982f-4c5bb49b2f68', 1000, '2026-06-23', 'Saldo Google - RE9 Imob - Fortaleza.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('6f1ed510-e32c-4d24-9cd9-6a536da4af0d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-23', 'Saldo Google - RE9 Imob - Fortaleza', '10481020-ffbc-4890-982f-4c5bb49b2f68', 'Pix', 'Saldo Google - RE9 Imob - Fortaleza.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('43700d9b-1152-4b58-abe8-da7cd61e59be', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angélica', 'Angélica', 500, '2026-06-29', 'paid', '2026-06-29', 500, 'Pago - Comissão Angélica.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('27cf434d-35d6-4d4f-a8c7-47b0d52a8880', 'e11042be-3d22-4048-9380-ac71e8dc9252', '43700d9b-1152-4b58-abe8-da7cd61e59be', 500, '2026-06-29', 'Pago - Comissão Angélica.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('b92a97b6-920c-462d-8937-ae0b47e2637b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-06-29', 'Comissão Angélica', '43700d9b-1152-4b58-abe8-da7cd61e59be', 'Pix', 'Pago - Comissão Angélica.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('407410ac-f768-433a-bb85-5c6c50bc9ede', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Creci Assis', 'Assis', 689, '2026-06-29', 'paid', '2026-06-29', 689, 'Pago - Creci Assis.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('f41b4cf0-cdf9-4c9f-b48c-c9673080b413', 'e11042be-3d22-4048-9380-ac71e8dc9252', '407410ac-f768-433a-bb85-5c6c50bc9ede', 689, '2026-06-29', 'Pago - Creci Assis.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('e0e51dab-e036-40a7-9673-36331da08791', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 689, '2026-06-29', 'Creci Assis', '407410ac-f768-433a-bb85-5c6c50bc9ede', 'Pix', 'Pago - Creci Assis.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('b1b3bb8e-0311-4f55-ab20-201cdd42de86', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno', 'Reno', 6752.9, '2026-06-29', 'paid', '2026-06-29', 6752.9, 'Pago - Comissão Reno - 29062026.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('9d5daef6-3233-4d28-94b6-aeec76519b3c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'b1b3bb8e-0311-4f55-ab20-201cdd42de86', 6752.9, '2026-06-29', 'Pago - Comissão Reno - 29062026.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('58e3c2dc-b002-46c9-846c-2f7760297c16', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 6752.9, '2026-06-29', 'Comissão Reno', 'b1b3bb8e-0311-4f55-ab20-201cdd42de86', 'Pix', 'Pago - Comissão Reno - 29062026.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('3680f825-47a7-49a5-bc56-9d92be82e397', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Atlântico, Seano, Orizon e Inc Cambeba', 'Meta', 1000, '2026-06-29', 'paid', '2026-06-29', 1000, 'Pago - Saldo Meta - Atlântico, Seano, Orizon e Inc Cambeba.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d2f02c2b-404d-4e2b-aa12-f34d58929ebb', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3680f825-47a7-49a5-bc56-9d92be82e397', 1000, '2026-06-29', 'Pago - Saldo Meta - Atlântico, Seano, Orizon e Inc Cambeba.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('b2e28cc6-2201-4763-b2bf-357d1cf57cc6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-29', 'Saldo Meta - Atlântico, Seano, Orizon e Inc Cambeba', '3680f825-47a7-49a5-bc56-9d92be82e397', 'Pix', 'Pago - Saldo Meta - Atlântico, Seano, Orizon e Inc Cambeba.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('4ceaa846-950f-45fb-abcc-eff61304348d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob - Outros Estados', 'Meta', 400, '2026-06-30', 'paid', '2026-06-30', 400, 'Saldo Google - RE9 Imob - Outros Estados.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d0413231-de7e-4fc6-963b-f9782955cbd2', 'e11042be-3d22-4048-9380-ac71e8dc9252', '4ceaa846-950f-45fb-abcc-eff61304348d', 400, '2026-06-30', 'Saldo Google - RE9 Imob - Outros Estados.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('64c2b061-b5eb-4d76-a11a-0640d92e288b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-06-30', 'Saldo Google - Re9 Imob - Outros Estados', '4ceaa846-950f-45fb-abcc-eff61304348d', 'Pix', 'Saldo Google - RE9 Imob - Outros Estados.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('c4b70238-bc64-4f5f-a375-678f2990eade', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob - Interior', 'Meta', 300, '2026-06-30', 'paid', '2026-06-30', 300, 'Saldo Google - RE9 Imob - Interior (1).jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5b5dd928-073c-498a-8db3-370a92b3188a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c4b70238-bc64-4f5f-a375-678f2990eade', 300, '2026-06-30', 'Saldo Google - RE9 Imob - Interior (1).jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('42c36635-2276-4325-ad33-bfd5550d3989', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-06-30', 'Saldo Google - Re9 Imob - Interior', 'c4b70238-bc64-4f5f-a375-678f2990eade', 'Pix', 'Saldo Google - RE9 Imob - Interior (1).jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('cb112b28-bad9-4a42-abab-cc1077af4d74', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob - Imoveis Praia', 'Meta', 400, '2026-06-30', 'paid', '2026-06-30', 400, 'Saldo Google - RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('1be685ed-c9a4-455f-a2d2-857a25adef29', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'cb112b28-bad9-4a42-abab-cc1077af4d74', 400, '2026-06-30', 'Saldo Google - RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('0a4f06de-51fd-423d-9bc9-c9924b7cec95', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-06-30', 'Saldo Google - Re9 Imob - Imoveis Praia', 'cb112b28-bad9-4a42-abab-cc1077af4d74', 'Pix', 'Saldo Google - RE9 Imob - Imóveis Praia.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('86bca1f7-2e19-4612-aa15-4633753d9bf1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Fortaleza', 'Meta', 1000, '2026-06-30', 'paid', '2026-06-30', 1000, 'Saldo Google - RE9 Imob - Fortaleza (1).jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('fb84ad9e-3519-4765-9769-39386d24e56d', 'e11042be-3d22-4048-9380-ac71e8dc9252', '86bca1f7-2e19-4612-aa15-4633753d9bf1', 1000, '2026-06-30', 'Saldo Google - RE9 Imob - Fortaleza (1).jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('3bad78b4-60e8-47f2-b232-6070a86fc96c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-06-30', 'Saldo Google - RE9 Imob - Fortaleza', '86bca1f7-2e19-4612-aa15-4633753d9bf1', 'Pix', 'Saldo Google - RE9 Imob - Fortaleza (1).jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('34a449b6-d7c5-41f0-a577-f8879bb8fae6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob - Internacional', 'Meta', 300, '2026-06-30', 'paid', '2026-06-30', 300, 'Saldo Google - RE9 Imob - Internacional.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('097e5f02-d20b-47f6-8952-564196e6b841', 'e11042be-3d22-4048-9380-ac71e8dc9252', '34a449b6-d7c5-41f0-a577-f8879bb8fae6', 300, '2026-06-30', 'Saldo Google - RE9 Imob - Internacional.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('abf001f6-4a74-4729-bef5-69aa8183b0cf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-06-30', 'Saldo Google - Re9 Imob - Internacional', '34a449b6-d7c5-41f0-a577-f8879bb8fae6', 'Pix', 'Saldo Google - RE9 Imob - Internacional.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('3436442b-6df6-4a9f-bd42-ee8f36bde8bb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Bônus Reno', 'Reno', 1492.05, '2026-07-01', 'paid', '2026-07-01', 1492.05, 'Pago - Bônus Reno.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('6f6c0d53-7cac-4142-918e-d8eeb8aa41e7', 'e11042be-3d22-4048-9380-ac71e8dc9252', '3436442b-6df6-4a9f-bd42-ee8f36bde8bb', 1492.05, '2026-07-01', 'Pago - Bônus Reno.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('f1e2de6f-ab7b-47b0-91d5-e148bdd068db', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1492.05, '2026-07-01', 'Bônus Reno', '3436442b-6df6-4a9f-bd42-ee8f36bde8bb', 'Pix', 'Pago - Bônus Reno.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('bbcc6489-d9cb-4453-83ef-1c896f0a883d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Captação Assis', 'Assis', 100, '2026-07-01', 'paid', '2026-07-01', 100, 'Pago - Captação Assis.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('7176aa04-9706-4086-b5bd-af8f5207c47d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'bbcc6489-d9cb-4453-83ef-1c896f0a883d', 100, '2026-07-01', 'Pago - Captação Assis.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('b4ec91a8-21f6-4d40-9a8b-f4fb1170769c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 100, '2026-07-01', 'Captação Assis', 'bbcc6489-d9cb-4453-83ef-1c896f0a883d', 'Pix', 'Pago - Captação Assis.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('f546ea12-41f7-4f8d-b8a6-602f91651da5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angélica', 'Angélica', 500, '2026-07-01', 'paid', '2026-07-01', 500, 'Pago - Comissão Angélica - 01072026.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('e9644468-5b53-4aa7-9c0e-1088295a2990', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f546ea12-41f7-4f8d-b8a6-602f91651da5', 500, '2026-07-01', 'Pago - Comissão Angélica - 01072026.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('a76d7c5d-ba97-4c60-b39e-e06759001a95', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-07-01', 'Comissão Angélica', 'f546ea12-41f7-4f8d-b8a6-602f91651da5', 'Pix', 'Pago - Comissão Angélica - 01072026.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('b3400cb8-18a5-4ad0-9e3a-4980e1f66f49', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno', 'Reno', 13675.72, '2026-07-01', 'paid', '2026-07-01', 13675.72, 'Pago - Comissão Reno - 01072026.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('58e87a3e-7a19-43a7-8390-e68e872f65b8', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'b3400cb8-18a5-4ad0-9e3a-4980e1f66f49', 13675.72, '2026-07-01', 'Pago - Comissão Reno - 01072026.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('da4f48c7-7ffb-41cc-a7b7-4c853582dbf4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 13675.72, '2026-07-01', 'Comissão Reno', 'b3400cb8-18a5-4ad0-9e3a-4980e1f66f49', 'Pix', 'Pago - Comissão Reno - 01072026.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('384edea0-a364-402a-9838-bec0417e922d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pagamento dos Chips', 'Reno', 1500, '2026-07-02', 'paid', '2026-07-02', 1500, 'Pago - Chips.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('3eeaddf7-d741-47a5-8b63-7957a3e45f5e', 'e11042be-3d22-4048-9380-ac71e8dc9252', '384edea0-a364-402a-9838-bec0417e922d', 1500, '2026-07-02', 'Pago - Chips.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('ef34a3f5-8785-4aac-82a2-c7a5636eb486', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1500, '2026-07-02', 'Pagamento dos Chips', '384edea0-a364-402a-9838-bec0417e922d', 'Pix', 'Pago - Chips.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('a47c5bc0-1a23-4d31-a484-bffdefeb01bc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Imposto Junho/26', 'Receita Federal', 6331.53, '2026-07-07', 'paid', '2026-07-07', 6331.53, 'Pago - Impostos Junho.pdf');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('4222011b-5a2f-4e81-b1a7-548cef8149ea', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'a47c5bc0-1a23-4d31-a484-bffdefeb01bc', 6331.53, '2026-07-07', 'Pago - Impostos Junho.pdf');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('1199d1bf-b8a3-4ee3-b453-45163f359d56', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 6331.53, '2026-07-07', 'Imposto Junho/26', 'a47c5bc0-1a23-4d31-a484-bffdefeb01bc', 'Pix', 'Pago - Impostos Junho.pdf');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('2492e6f5-1c36-40f5-baa3-9d6b8b7b2f5e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Fortaleza', 'Meta', 1000, '2026-07-13', 'paid', '2026-07-13', 1000, 'Saldo Google - RE9 Imob - Fortaleza - 1000.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b0e672d5-0dc7-4156-8375-9ea4973bd889', 'e11042be-3d22-4048-9380-ac71e8dc9252', '2492e6f5-1c36-40f5-baa3-9d6b8b7b2f5e', 1000, '2026-07-13', 'Saldo Google - RE9 Imob - Fortaleza - 1000.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('9444fb9a-d88c-4aab-99b4-e5ff34af8441', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-07-13', 'Saldo Google - RE9 Imob - Fortaleza', '2492e6f5-1c36-40f5-baa3-9d6b8b7b2f5e', 'Pix', 'Saldo Google - RE9 Imob - Fortaleza - 1000.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('94574346-a850-49e3-ad4b-9a2efc5dce5e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Imóveis Praia', 'Meta', 500, '2026-07-13', 'paid', '2026-07-13', 500, 'Saldo Google - RE9 Imob - Imóveis Praia - 500.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b71e38f3-cc47-436a-ac97-cc0b0fe9faf7', 'e11042be-3d22-4048-9380-ac71e8dc9252', '94574346-a850-49e3-ad4b-9a2efc5dce5e', 500, '2026-07-13', 'Saldo Google - RE9 Imob - Imóveis Praia - 500.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('7ec564b4-8508-47de-ac99-1d09113742da', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-07-13', 'Saldo Google - RE9 Imob - Imóveis Praia', '94574346-a850-49e3-ad4b-9a2efc5dce5e', 'Pix', 'Saldo Google - RE9 Imob - Imóveis Praia - 500.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('f409e475-e9c3-4243-9c89-cb10f8e27425', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Internacional', 'Meta', 400, '2026-07-13', 'paid', '2026-07-13', 400, 'Saldo Google - RE9 Imob - Internacional - 400.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('61ce4e1b-4b82-49ae-993d-ae9acc02f5b1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'f409e475-e9c3-4243-9c89-cb10f8e27425', 400, '2026-07-13', 'Saldo Google - RE9 Imob - Internacional - 400.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('d2ccfca9-8e01-4484-bbdc-8030d6d09853', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-07-13', 'Saldo Google - RE9 Imob - Internacional', 'f409e475-e9c3-4243-9c89-cb10f8e27425', 'Pix', 'Saldo Google - RE9 Imob - Internacional - 400.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('a8994e1f-5378-48ea-8381-7926e2c00226', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - RE9 Imob - Outros Estados', 'Meta', 400, '2026-07-13', 'paid', '2026-07-13', 400, 'Saldo Google - RE9 Imob - Outros Estados - 400.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2987e2db-8321-48c0-a885-6846f98be38d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'a8994e1f-5378-48ea-8381-7926e2c00226', 400, '2026-07-13', 'Saldo Google - RE9 Imob - Outros Estados - 400.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('681f9f8c-b1a1-4158-9a95-30b9c4585c6c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-07-13', 'Saldo Google - RE9 Imob - Outros Estados', 'a8994e1f-5378-48ea-8381-7926e2c00226', 'Pix', 'Saldo Google - RE9 Imob - Outros Estados - 400.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('7851aaa6-8e1b-43d2-a194-6a672d01300a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Adiantamento Quinzenal', 'Angélica', 1250, '2026-07-14', 'paid', '2026-07-14', 1250, 'Pago - Adiantamento Quinzenal.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('23d6de78-fc88-4238-a9ba-547522d2b6ba', 'e11042be-3d22-4048-9380-ac71e8dc9252', '7851aaa6-8e1b-43d2-a194-6a672d01300a', 1250, '2026-07-14', 'Pago - Adiantamento Quinzenal.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('ba417030-b3d0-4f05-af7d-9914cde3a3d5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1250, '2026-07-14', 'Adiantamento Quinzenal', '7851aaa6-8e1b-43d2-a194-6a672d01300a', 'Pix', 'Pago - Adiantamento Quinzenal.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('5846b91d-2f0d-46be-82a2-86abd3d09da7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno', 'Reno', 15163.36, '2026-07-14', 'paid', '2026-07-14', 15163.36, 'Pago - Comissão Reno 15k.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b0d4fe4f-efe9-4338-86bf-195037ea5201', 'e11042be-3d22-4048-9380-ac71e8dc9252', '5846b91d-2f0d-46be-82a2-86abd3d09da7', 15163.36, '2026-07-14', 'Pago - Comissão Reno 15k.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('04e8fecc-3db9-467c-b8c0-91691c9da3bb', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 15163.36, '2026-07-14', 'Comissão Reno', '5846b91d-2f0d-46be-82a2-86abd3d09da7', 'Pix', 'Pago - Comissão Reno 15k.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ad4229c9-455d-4c12-99a3-dee7c1dabf4a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno', 'Reno', 12977.11, '2026-07-20', 'paid', '2026-07-20', 12977.11, 'Pago - Comissão Reno 12k.jpegg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5ae7381c-07a2-4418-b5d2-1f1df27c0f8e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ad4229c9-455d-4c12-99a3-dee7c1dabf4a', 12977.11, '2026-07-20', 'Pago - Comissão Reno 12k.jpegg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('65ea6e0b-cb51-4b58-b548-c4b117029903', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 12977.11, '2026-07-20', 'Comissão Reno', 'ad4229c9-455d-4c12-99a3-dee7c1dabf4a', 'Pix', 'Pago - Comissão Reno 12k.jpegg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('e69f5703-e132-46e7-80c2-6141526db589', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angélica', 'Angélica', 500, '2026-07-20', 'paid', '2026-07-20', 500, 'Pago - Comissão Angélica 1.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('08a7fd30-6885-450b-8939-4c63f0708b6b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'e69f5703-e132-46e7-80c2-6141526db589', 500, '2026-07-20', 'Pago - Comissão Angélica 1.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('e738086b-9c4e-47a8-a622-cb15b25b4edf', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-07-20', 'Comissão Angélica', 'e69f5703-e132-46e7-80c2-6141526db589', 'Pix', 'Pago - Comissão Angélica 1.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('30281daf-42a0-43fd-ba10-cd345488da8a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Serviço Financeiro', 'Nummis', 1500, '2026-07-20', 'paid', '2026-07-20', 1500, 'Pago - Pagamento para Nummis.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('54d67616-fe0f-4961-be25-b717bbeeb7cf', 'e11042be-3d22-4048-9380-ac71e8dc9252', '30281daf-42a0-43fd-ba10-cd345488da8a', 1500, '2026-07-20', 'Pago - Pagamento para Nummis.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('bf442914-367e-4366-8354-502276dc10da', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1500, '2026-07-20', 'Serviço Financeiro', '30281daf-42a0-43fd-ba10-cd345488da8a', 'Pix', 'Pago - Pagamento para Nummis.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('ad890dc0-07bc-4a3a-8d67-dc5175c982ef', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno', 'Reno', 4371.37, '2026-07-20', 'paid', '2026-07-20', 4371.37, 'Pago - Comissão Reno 4k.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('ae2a0d65-1db6-4db6-be54-34bbc153e7f6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ad890dc0-07bc-4a3a-8d67-dc5175c982ef', 4371.37, '2026-07-20', 'Pago - Comissão Reno 4k.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('85c72a56-2b9a-41d5-b024-7b43f9783d96', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 4371.37, '2026-07-20', 'Comissão Reno', 'ad890dc0-07bc-4a3a-8d67-dc5175c982ef', 'Pix', 'Pago - Comissão Reno 4k.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('94445d31-3e49-4db9-b474-01e0cb4a8110', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Angélica', 'Angélica', 500, '2026-07-20', 'paid', '2026-07-20', 500, 'Pago - Comissão Angélica 2.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('9a9cc1e6-f809-4a5a-bdc1-f4e6244591da', 'e11042be-3d22-4048-9380-ac71e8dc9252', '94445d31-3e49-4db9-b474-01e0cb4a8110', 500, '2026-07-20', 'Pago - Comissão Angélica 2.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('f7d59706-94ad-4585-96c2-72d9318e36ff', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-07-20', 'Comissão Angélica', '94445d31-3e49-4db9-b474-01e0cb4a8110', 'Pix', 'Pago - Comissão Angélica 2.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('20e1bdb3-e9f4-4287-a246-6e7566a4f8c6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Contabilidade', 'Contador', 300, '2026-07-20', 'paid', '2026-07-20', 300, 'Pago - Comissão Contabilidade.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d863926c-7b76-4ea4-b326-fbfc58429518', 'e11042be-3d22-4048-9380-ac71e8dc9252', '20e1bdb3-e9f4-4287-a246-6e7566a4f8c6', 300, '2026-07-20', 'Pago - Comissão Contabilidade.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('d0d5277b-da5a-4f56-b97b-b04bb8212fd7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-07-20', 'Comissão Contabilidade', '20e1bdb3-e9f4-4287-a246-6e7566a4f8c6', 'Pix', 'Pago - Comissão Contabilidade.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('0312e3fa-de0c-4bd5-b849-91ec90376945', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Bella Aldeota, Bella Rio, Oasy e Myrage', 'Meta', 2000, '2026-07-20', 'paid', '2026-07-20', 2000, 'Pago - Saldo Meta - Bella Aldeota, Bella Rio, Oasy e Myrage.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('37aa23b7-e665-44ac-a4c2-63facdc38248', 'e11042be-3d22-4048-9380-ac71e8dc9252', '0312e3fa-de0c-4bd5-b849-91ec90376945', 2000, '2026-07-20', 'Pago - Saldo Meta - Bella Aldeota, Bella Rio, Oasy e Myrage.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('c6815ec0-f6c6-491f-8531-fd3477a580fd', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2000, '2026-07-20', 'Saldo Meta - Bella Aldeota, Bella Rio, Oasy e Myrage', '0312e3fa-de0c-4bd5-b849-91ec90376945', 'Pix', 'Pago - Saldo Meta - Bella Aldeota, Bella Rio, Oasy e Myrage.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('907d5068-87d9-4f2c-b49b-9f0478c51b19', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta - Mlar Cambeba, Lago e Inc', 'Meta', 1500, '2026-07-20', 'paid', '2026-07-20', 1500, 'Pago - Saldo Meta - Mlar Cambeba, Lago e Inc.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('722d565b-062e-425e-9847-f6c240bd7883', 'e11042be-3d22-4048-9380-ac71e8dc9252', '907d5068-87d9-4f2c-b49b-9f0478c51b19', 1500, '2026-07-20', 'Pago - Saldo Meta - Mlar Cambeba, Lago e Inc.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('a28ef5c4-b445-40cf-9378-09708e90bc06', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1500, '2026-07-20', 'Saldo Meta - Mlar Cambeba, Lago e Inc', '907d5068-87d9-4f2c-b49b-9f0478c51b19', 'Pix', 'Pago - Saldo Meta - Mlar Cambeba, Lago e Inc.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('7e4087ef-f148-46ef-be7c-c69c51bf96c5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob Fortaleza', 'Google', 1000, '2026-07-20', 'paid', '2026-07-20', 1000, 'Pago - Saldo Google - Re9 Imob Fortaleza.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d7fa4f9a-fc40-4211-a556-9d4edc98002e', 'e11042be-3d22-4048-9380-ac71e8dc9252', '7e4087ef-f148-46ef-be7c-c69c51bf96c5', 1000, '2026-07-20', 'Pago - Saldo Google - Re9 Imob Fortaleza.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('6ec37f52-a7ff-4ad7-a1b4-b06e9f7f4c65', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-07-20', 'Saldo Google - Re9 Imob Fortaleza', '7e4087ef-f148-46ef-be7c-c69c51bf96c5', 'Pix', 'Pago - Saldo Google - Re9 Imob Fortaleza.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('afe21109-0212-44b1-8812-7caced4b993c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob Interior', 'Google', 300, '2026-07-20', 'paid', '2026-07-20', 300, 'Pago - Saldo Google - Re9 Imob Interior.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('79b3c568-92b3-4965-b321-801386e2ef95', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'afe21109-0212-44b1-8812-7caced4b993c', 300, '2026-07-20', 'Pago - Saldo Google - Re9 Imob Interior.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('185bbd55-4cfc-4c85-9727-095a389f76c9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 300, '2026-07-20', 'Saldo Google - Re9 Imob Interior', 'afe21109-0212-44b1-8812-7caced4b993c', 'Pix', 'Pago - Saldo Google - Re9 Imob Interior.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('8e4e08e3-b28e-4565-80c5-4101fc39af5a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google - Re9 Imob Outros Estados', 'Google', 400, '2026-07-20', 'paid', '2026-07-20', 400, 'Pago - Saldo Google - Re9 Imob Outros Estados.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('9611f77d-c0ce-42f5-b8c9-e82dee94885b', 'e11042be-3d22-4048-9380-ac71e8dc9252', '8e4e08e3-b28e-4565-80c5-4101fc39af5a', 400, '2026-07-20', 'Pago - Saldo Google - Re9 Imob Outros Estados.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('ee4d5bef-8551-4b6e-98d4-f86ee04493ac', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 400, '2026-07-20', 'Saldo Google - Re9 Imob Outros Estados', '8e4e08e3-b28e-4565-80c5-4101fc39af5a', 'Pix', 'Pago - Saldo Google - Re9 Imob Outros Estados.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('87bc41c0-670d-4328-87f3-d0a7cb310845', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Pagamento OLX', 'Reno', 275.9, '2026-07-28', 'paid', '2026-07-28', 275.9, 'Pago - OLX.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('100e129e-763c-4576-aee9-55803402cf18', 'e11042be-3d22-4048-9380-ac71e8dc9252', '87bc41c0-670d-4328-87f3-d0a7cb310845', 275.9, '2026-07-28', 'Pago - OLX.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('05503656-0ab0-48ff-b22e-3759f2ad88a7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 275.9, '2026-07-28', 'Pagamento OLX', '87bc41c0-670d-4328-87f3-d0a7cb310845', 'Pix', 'Pago - OLX.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('70fd3c31-1136-44c9-84c7-ae9b55547bc3', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google 500 - RE9 Imob - Outros Estados', 'Google', 500, '2026-07-29', 'paid', '2026-07-29', 500, 'Pago - Saldo Google 500 - RE9 Imob - Outros Estados.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('5f171f17-66e1-408c-b458-61c43198bbf4', 'e11042be-3d22-4048-9380-ac71e8dc9252', '70fd3c31-1136-44c9-84c7-ae9b55547bc3', 500, '2026-07-29', 'Pago - Saldo Google 500 - RE9 Imob - Outros Estados.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('384420d6-1b5c-4049-91a6-e5fe728db1ba', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 500, '2026-07-29', 'Saldo Google 500 - RE9 Imob - Outros Estados', '70fd3c31-1136-44c9-84c7-ae9b55547bc3', 'Pix', 'Pago - Saldo Google 500 - RE9 Imob - Outros Estados.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('613f155d-7076-459a-b982-5229fadc2831', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta 2000 - Bella Aldeota, Rio, Oasy e Myrage', 'Meta', 2000, '2026-07-29', 'paid', '2026-07-29', 2000, 'Pago - Saldo Meta 2000 - Bella Aldeota, Rio, Oasy e Myrage.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('b01f0b0a-2eb5-4f83-a1e4-b283e606eefe', 'e11042be-3d22-4048-9380-ac71e8dc9252', '613f155d-7076-459a-b982-5229fadc2831', 2000, '2026-07-29', 'Pago - Saldo Meta 2000 - Bella Aldeota, Rio, Oasy e Myrage.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('c629b31d-eed4-43d8-af4d-69a467ea46e4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2000, '2026-07-29', 'Saldo Meta 2000 - Bella Aldeota, Rio, Oasy e Myrage', '613f155d-7076-459a-b982-5229fadc2831', 'Pix', 'Pago - Saldo Meta 2000 - Bella Aldeota, Rio, Oasy e Myrage.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('755a948b-a0bd-46f3-9a5e-dd3700d8e123', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta 1000 - MLar Cambeba, Lago e Inc Cambeba', 'Meta', 1000, '2026-07-29', 'paid', '2026-07-29', 1000, 'Pago - Saldo Meta 1000 - MLar Cambeba, Lago e Inc Cambeba.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('2c8563fe-3d46-4492-b9da-e810cbd5e002', 'e11042be-3d22-4048-9380-ac71e8dc9252', '755a948b-a0bd-46f3-9a5e-dd3700d8e123', 1000, '2026-07-29', 'Pago - Saldo Meta 1000 - MLar Cambeba, Lago e Inc Cambeba.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('a70c3e19-8b3b-4ef9-96d1-e03fc58f158c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-07-29', 'Saldo Meta 1000 - MLar Cambeba, Lago e Inc Cambeba', '755a948b-a0bd-46f3-9a5e-dd3700d8e123', 'Pix', 'Pago - Saldo Meta 1000 - MLar Cambeba, Lago e Inc Cambeba.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('c72f84da-fd65-449f-a7a6-05becb517f1b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta 2000 - Maré, BS Wave e Vista Coqueiral', 'Meta', 2000, '2026-07-29', 'paid', '2026-07-29', 2000, 'Pago - Saldo Meta 2000 - Maré, BS Wave e Vista Coqueiral.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('97dce96a-629f-41ab-bece-d9305aac1479', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'c72f84da-fd65-449f-a7a6-05becb517f1b', 2000, '2026-07-29', 'Pago - Saldo Meta 2000 - Maré, BS Wave e Vista Coqueiral.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('27faf1aa-6343-45a4-85e0-5520740b9802', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2000, '2026-07-29', 'Saldo Meta 2000 - Maré, BS Wave e Vista Coqueiral', 'c72f84da-fd65-449f-a7a6-05becb517f1b', 'Pix', 'Pago - Saldo Meta 2000 - Maré, BS Wave e Vista Coqueiral.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('4d075ed3-a6bf-4937-b3f5-cae6d90ee0a5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Meta 1000 - La Vie e Inc Parquelândia', 'Meta', 1000, '2026-07-29', 'paid', '2026-07-29', 1000, 'Pago - Saldo Meta 1000 - La Vie e Inc Parquelândia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('7e98b6bc-6399-4abf-91c1-dbcb1c757740', 'e11042be-3d22-4048-9380-ac71e8dc9252', '4d075ed3-a6bf-4937-b3f5-cae6d90ee0a5', 1000, '2026-07-29', 'Pago - Saldo Meta 1000 - La Vie e Inc Parquelândia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('8f4b9598-1303-4bd3-9ff3-226f135d593c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-07-29', 'Saldo Meta 1000 - La Vie e Inc Parquelândia', '4d075ed3-a6bf-4937-b3f5-cae6d90ee0a5', 'Pix', 'Pago - Saldo Meta 1000 - La Vie e Inc Parquelândia.jpeg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('26f3787c-9f5c-4da7-9d02-baab2e678087', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google 2000 - RE9 Imob - Fortaleza', 'Google', 2000, '2026-07-29', 'paid', '2026-07-29', 2000, 'Pago - Saldo Google 2000 - RE9 Imob - Fortaleza.jpegg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('90b218d1-5465-4058-9c74-271388918138', 'e11042be-3d22-4048-9380-ac71e8dc9252', '26f3787c-9f5c-4da7-9d02-baab2e678087', 2000, '2026-07-29', 'Pago - Saldo Google 2000 - RE9 Imob - Fortaleza.jpegg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('9efb7269-0e69-43b5-b130-6b089e514470', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 2000, '2026-07-29', 'Saldo Google 2000 - RE9 Imob - Fortaleza', '26f3787c-9f5c-4da7-9d02-baab2e678087', 'Pix', 'Pago - Saldo Google 2000 - RE9 Imob - Fortaleza.jpegg');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, paid_at, paid_amount, notes)
    VALUES ('5e5d80a1-33c5-4a4f-a626-5b443b98a50a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Saldo Google 1000 - RE9 Imob - Imóveis Praia', 'Google', 1000, '2026-07-29', 'paid', '2026-07-29', 1000, 'Pago - Saldo Google 1000 - RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO settlements (id, company_id, payable_id, amount, settled_at, proof_url)
    VALUES ('d6cbd016-1a8f-4d5d-a530-fead59984c06', 'e11042be-3d22-4048-9380-ac71e8dc9252', '5e5d80a1-33c5-4a4f-a626-5b443b98a50a', 1000, '2026-07-29', 'Pago - Saldo Google 1000 - RE9 Imob - Imóveis Praia.jpeg');

    INSERT INTO transactions (id, company_id, type, amount, date, description, payable_id, payment_method, proof_url)
    VALUES ('9506f894-fcab-46ee-885d-d385503ed962', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'expense', 1000, '2026-07-29', 'Saldo Google 1000 - RE9 Imob - Imóveis Praia', '5e5d80a1-33c5-4a4f-a626-5b443b98a50a', 'Pix', 'Pago - Saldo Google 1000 - RE9 Imob - Imóveis Praia.jpeg');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('ad086dce-1207-4c58-8050-55ba84e622fa', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão André — MLar Kennedy Bônus R$5.000', 'Lucirene Souza', 2237.75, '2026-06-30', 'open', 'Corretor: André');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('615ba395-bcf4-4ce0-b488-8516bb324e6c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão André — Bônus', 'Lucirene Souza', 2500, '2026-08-01', 'open', 'Corretor: André');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('b1b3e751-afae-4761-980a-2a4ca1a14390', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão André — MLar Cambeba 1104', 'Luana', 6262.2, '2026-06-30', 'open', 'Corretor: André');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('d4ec283b-4b91-44c7-acd1-5db933211549', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão André — MLar Cambeba 905', 'Vinicius', 6219.34, '2026-06-30', 'open', 'Corretor: André');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('4c01102d-86b4-421d-a4df-199972b904a1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno — Bella Aldeota 1306', 'Marcio Anderson', 16971.18, '2026-07-31', 'open', 'Corretor: Reno');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('a79a2b6f-244e-46c4-9893-3676582d03e7', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno — Enjoy 1201', 'Mara Tailane Moreira da Silva', 11462.65, '2026-08-26', 'open', 'Corretor: Reno');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, notes)
    VALUES ('03db43de-cc26-4383-a46d-2c71d5834c0b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — Bônus', 'André', 2237.75, '2026-08-01', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, notes)
    VALUES ('e2e3e777-eea6-4e1c-99fc-55f5c79f5040', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — MLar Cambeba 1104', 'André', 6262.2, '2026-06-30', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, notes)
    VALUES ('9a999ddf-75d0-4e6e-b8c0-560da9e6325a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — MLar Cambeba 905', 'André', 6219.34, '2026-06-30', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, notes)
    VALUES ('9c37da5c-497a-41bf-9a3e-055570bc1f17', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — Bella Aldeota 1306', 'Reno', 8485.59, '2026-08-31', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, notes)
    VALUES ('4f8f066d-5578-4854-914c-fbad70eda020', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — Bella Aldeota 1307', 'Angélica', 500, '2026-08-31', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, notes)
    VALUES ('c4eece15-f265-4dc9-91a3-d285bfc27753', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — Enjoy 1201 (Mara Tailane)', 'Soraya', 11462.65, '2026-08-26', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_name, amount, due_date, status, notes)
    VALUES ('1c90f799-67fb-4f75-9a22-2dbab338207c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — Enjoy 1201 (Mara Tailane)', 'Angélica', 500, '2026-08-26', 'open', '');
  
COMMIT;