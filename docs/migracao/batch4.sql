BEGIN;

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('9703f8b0-62ff-465e-a90d-4d6f7aa53c14', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão André — MLar Kennedy Bônus R$5.000', 'Lucirene Souza', 2237.75, '2026-06-30', 'open', 'Corretor: André');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('9c169a17-3e07-439d-8a7d-c0a71aa8b40e', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão André — Bônus', 'Lucirene Souza', 2500, '2026-08-01', 'open', 'Corretor: André');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('3b581916-8c56-4cca-8395-e5e3dd317552', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão André — MLar Cambeba 1104', 'Luana', 6262.2, '2026-06-30', 'open', 'Corretor: André');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('bfcf34ff-f80d-4cf2-a405-41f7574372b1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão André — MLar Cambeba 905', 'Vinicius', 6219.34, '2026-06-30', 'open', 'Corretor: André');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('5c979086-11ed-44bf-9977-d96015d42b35', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno — Bella Aldeota 1306', 'Marcio Anderson', 16971.18, '2026-07-31', 'open', 'Corretor: Reno');
  

    INSERT INTO receivables (id, company_id, description, client_name, amount, due_date, status, notes)
    VALUES ('171ac53f-585c-4522-9373-3a99ea12908b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Comissão Reno — Enjoy 1201', 'Mara Tailane Moreira da Silva', 11462.65, '2026-08-26', 'open', 'Corretor: Reno');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, notes)
    VALUES ('7b70ae0c-591e-45ad-b797-daabfd0a84ca', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — Bônus', NULL, 2237.75, '2026-08-01', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, notes)
    VALUES ('06082a5c-47a6-48c3-8449-3fc3d30530a5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — MLar Cambeba 1104', NULL, 6262.2, '2026-06-30', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, notes)
    VALUES ('fe9c2a51-4ca3-4661-8c85-5929fab8a513', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — MLar Cambeba 905', NULL, 6219.34, '2026-06-30', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, notes)
    VALUES ('adcf1d49-38ec-4130-9736-27aaf9340f8c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — Bella Aldeota 1306', 'ea53d9ed-19d6-4504-8abf-34f7376becb8', 8485.59, '2026-08-31', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, notes)
    VALUES ('9858bc75-a9f8-4214-b8ef-e643e1847258', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — Bella Aldeota 1307', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 500, '2026-08-31', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, notes)
    VALUES ('155d8b61-4685-4e0d-8aca-284451f33baa', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — Enjoy 1201 (Mara Tailane)', NULL, 11462.65, '2026-08-26', 'open', '');
  

    INSERT INTO payables (id, company_id, description, supplier_id, amount, due_date, status, notes)
    VALUES ('0fada8e2-adae-4f36-84e4-6540d51de344', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Repasse — Enjoy 1201 (Mara Tailane)', 'd1069f67-12e7-4ea0-85da-a339c4c195da', 500, '2026-08-26', 'open', '');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('d1638e21-9ec9-4165-bb45-fff4e2ce7ccc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Nonato Gabriel Figueira', 297303.06, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('fa965158-755c-42ca-b3d4-987c5740b5a9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'd1638e21-9ec9-4165-bb45-fff4e2ce7ccc', 2961.23, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('df4d337a-f7e2-4bad-ab5b-c8e65be73f4c', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Clemilton Lima de Souza', 297303.06, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('ed46c843-aac4-4f98-b257-cb23c270664b', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'df4d337a-f7e2-4bad-ab5b-c8e65be73f4c', 3260.96, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('60e9a4ab-3d80-4fd9-812a-892f1f7fa9c5', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Lucirene Souza', 5000, '2026-05-01', 'active');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('303236aa-6cc8-4922-99ae-f3e51e40ab59', 'e11042be-3d22-4048-9380-ac71e8dc9252', '60e9a4ab-3d80-4fd9-812a-892f1f7fa9c5', 2237.75, 'pending');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('2f21f5a1-77e5-4e70-a150-c9ff5bbd82d0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Lucirene Souza', 371399.84, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('c6c63e16-b417-4e8b-8798-ddb581b905fb', 'e11042be-3d22-4048-9380-ac71e8dc9252', '2f21f5a1-77e5-4e70-a150-c9ff5bbd82d0', 6648.8, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('b8fe6333-df59-4cf7-97cb-7a7aec1898db', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Luana', 349804.35, '2026-05-01', 'active');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('da7d0321-b3cb-4247-ba3f-1f18243ee302', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'b8fe6333-df59-4cf7-97cb-7a7aec1898db', 6262.2, 'pending');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('646b77b1-5e89-4e7b-ad03-80f2f0ff77dc', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Vinicius', 347410.55, '2026-05-01', 'active');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('cd91e237-54a6-4760-96d6-4e57abd51446', 'e11042be-3d22-4048-9380-ac71e8dc9252', '646b77b1-5e89-4e7b-ad03-80f2f0ff77dc', 6219.34, 'pending');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('9429f450-f5a8-4aca-bc5e-0c43734cd9a6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Juliana Pontes', 352531.5, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('5608daec-9798-42e6-a6ab-710c98cdb65b', 'e11042be-3d22-4048-9380-ac71e8dc9252', '9429f450-f5a8-4aca-bc5e-0c43734cd9a6', 4324.38, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('ce0cf843-a158-4b94-b491-ebd4e1dbcb83', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Rafael Hermínio', 350000, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('0198e02e-8b28-41e1-a453-51a0e7fc0d03', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'ce0cf843-a158-4b94-b491-ebd4e1dbcb83', 6752.9, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('83de1f4a-e259-44c5-956d-b333015bd462', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Rafael Ditolvo', 506017.33, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('238624e7-8a5e-44cc-9434-3d061bdda1da', 'e11042be-3d22-4048-9380-ac71e8dc9252', '83de1f4a-e259-44c5-956d-b333015bd462', 9763.095, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('92b72604-b46c-45ab-83d2-9e4829f1df1d', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Marcio Anderson', 474002.21, '2026-05-01', 'active');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('898026c1-22ef-4df8-b99a-46eebe17b5e9', 'e11042be-3d22-4048-9380-ac71e8dc9252', '92b72604-b46c-45ab-83d2-9e4829f1df1d', 16971.18, 'pending');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('af878c18-efd7-4103-945b-b3f8e3c83569', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Beatriz Dias', 760998.58, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('0e00b312-f9e1-408f-8696-7d126c50f996', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'af878c18-efd7-4103-945b-b3f8e3c83569', 13623.4, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('9a623b44-a5e0-4438-b41b-67fb23d3baab', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Sávio Santanta', 622121.6, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('58862736-09a3-42f7-be2f-5968a9644f50', 'e11042be-3d22-4048-9380-ac71e8dc9252', '9a623b44-a5e0-4438-b41b-67fb23d3baab', 11137.22, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('7e8e2e9d-1c93-4eb4-b99f-ff9a62ad38d6', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Mateus Jereissati', 559786.91, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('5b04d40a-1252-45bd-b3a5-3bd2c5e6f942', 'e11042be-3d22-4048-9380-ac71e8dc9252', '7e8e2e9d-1c93-4eb4-b99f-ff9a62ad38d6', 10800.53, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('a1fa0c06-f50f-49fd-b3d2-37d85e246233', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Mateus Jereissati', 559786.91, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('4b7dcef8-fcb0-4114-ac5f-7e990ae09dc1', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'a1fa0c06-f50f-49fd-b3d2-37d85e246233', 10800.53, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('676b2ae7-275d-448c-89fe-362d6764651a', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Mateus Jereissati', 3000, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('4f8d06dc-0914-43b3-ba34-2c6abcd3a673', 'e11042be-3d22-4048-9380-ac71e8dc9252', '676b2ae7-275d-448c-89fe-362d6764651a', 1495, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('46880d17-1345-4744-bf2a-52ebe4292ed9', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Lia de Sousa Alexandre e Jonathan Silva Santos', 387000, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('996b130c-dfea-4b31-a2ae-641deb5dc2b2', 'e11042be-3d22-4048-9380-ac71e8dc9252', '46880d17-1345-4744-bf2a-52ebe4292ed9', 7466.778, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('53e104a2-cdf2-4397-9b3d-219b579d34c4', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Gilson Ferreira de Andrade', 708807, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('524a09c1-c8d1-46fa-a288-ff42b9d3e56c', 'e11042be-3d22-4048-9380-ac71e8dc9252', '53e104a2-cdf2-4397-9b3d-219b579d34c4', 13675.72226, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('cbfe302f-c6de-4d7a-b0d8-e336fc1141d0', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'José Jaime do Nascimento', 453132.94, '2026-05-01', 'settled');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('4ca62436-136c-4e23-a966-8a702dc25857', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'cbfe302f-c6de-4d7a-b0d8-e336fc1141d0', 8742.746944, 'received');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('020537d9-4c21-4b6e-9d97-1e14114d2428', 'e11042be-3d22-4048-9380-ac71e8dc9252', 'Mara Tailane Moreira da Silva', 594104.25, '2026-05-01', 'active');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('b46bd7fd-0f02-4687-90e4-c5364ddcbe6a', 'e11042be-3d22-4048-9380-ac71e8dc9252', '020537d9-4c21-4b6e-9d97-1e14114d2428', 11462.6474, 'pending');
  

    INSERT INTO sales (id, company_id, buyer_name, sale_value, sale_date, status)
    VALUES ('4377b594-bff8-4d9c-b53b-d01bcb799a1a', 'e11042be-3d22-4048-9380-ac71e8dc9252', '', 5856465.9, '2026-05-01', 'active');

    INSERT INTO commissions (id, company_id, sale_id, total_amount, status)
    VALUES ('12813c39-5628-4cfc-ae69-009aa4e1b0ed', 'e11042be-3d22-4048-9380-ac71e8dc9252', '4377b594-bff8-4d9c-b53b-d01bcb799a1a', 113258.515, 'pending');
  
COMMIT;