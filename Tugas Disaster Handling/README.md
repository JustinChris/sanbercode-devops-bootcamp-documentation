Case Study: Disaster Handling

On February 21st, 2024, experienced an outage that affected all users due to a database migration that went wrong. This prevented users from using the API (including sending emails) and accessing the dashboard from 05:01 to 17:05 UTC (about 12 hours).

The database migration accidentally deleted data from production servers. We immediately began the restoration process from a backup, which completed 6 hours later. Unfortunately, once it finished, we found that it failed to restore the data, so we had to start the restoration process a second time with a different backup.

During this time, no API requests were being accepted and no data being stored. For data created prior to the migration, there was 5 minute of data loss from when the migration started and the database went offline from 04:50:00 to 04:56:27 UTC. We are currently working on re-populating the data from this 5-minute window.

Timeline:
04:56: Database migration started
04:57: Noticed tables being dropped from the production database
05:01: Began restoring the database from a backup
05:02: Posted on status page, updating every 30-60 minutes until resolution
11:02: First restoration process completed
11:03: Realized the first backup failed and started to investigate
11:33: Found that the backup failed due to a wrong selection of the backup timestamp

What happened:
While building a feature, we performed a database migration command locally, but it incorrectly pointed to the production environment instead, which dropped all tables in production.

Impact:
All users were unable to send emails, use the API, or access the dashboard for 12 hours from 05:01 to 17:05 UTC.

For data created prior to the migration, there was 5 minutes of data loss from when the migration started and the database went offline from 04:50:00 to 04:56:27 UTC.

# Analysis

Root Cause:
Penyebab utamanya adalah kesalahan pada saat melakukan database migration. Kesalahan ini terjadi karena database migration yang seharusnya dilakukan pada environment development dijalankan pada environment production yang kemudian menyebabkan table deletion.

Faktor yang mendukung:
1. Kurangnya environment isolation

    Kurangnya separasi antar environment menyebabkan masalah ini mudah terjadi.
2. Proses pemulihan backup

    Terjadinya kesalahan pemilihan timestamp menambah waktu downtime.

Recovery Process:
1. Initial Process

    Setelah masalah terdeteksi, langsung menjalankan proses restorasi dari backup yang ada
2. Communication

    Incident langsung dikomunikasikan dengan tim terkait maupun dengan user yang terdampak.
3. Restoration effort

    Setelah proses recovery pertama gagal, dilakukan ulang proses recovery kedua.

Solution:
1. Tambah validasi untuk semua database operations terutama di environment production.
2. Gunakan Begin Transaction saat ingin melakukan database operations.
3. Berikan timestamp backup database yang jelas.
4. Lakukan separasi environment antara development dan production.

