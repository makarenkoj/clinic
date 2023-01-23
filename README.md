Ruby version '3.1.2'

Тестове завдання для RoR dev
Реалізувати проєкт з управління поліклінікою
Види користувачів:
- пацієнт (User)
- лікар (Doctor)
- Admin
Для кожного виду користувачів необхідно реалізувати наступний функціонал:
1. Пацієнт може зареєструватися, увійти до свого особистого кабінету (Profile),
переглядати список лікарів за категоріями, записатися на прийом, отримати
рекомендації від лікаря після прийому.
2. Лікар може увійти в особистий кабінет (Profile), переглянути список пацієнтів, що
записалися, надати рекомендації пацієнту. Лікар може відноситися до певної
категорії (терапевт, кардіолог тощо).
3. Адмін має доступ до списку пацієнтів та лікарів. Може створювати категорії, лікарів,
асайнити певного лікаря до категорії (можна реалізувати через
ActiveAdmin/Administrate).
Вимоги до аутентифікації та авторизації:
- використовувати devise;
- реалізувати login через phone-password;
- використовувати gem cancancan для розмежування прав користувачів;
Вимоги до таблиці категорій:
- валідація на унікальність за ім'ям;
- можливість додавання кількох лікарів;
Вимоги до таблиць Лікар-Пацієнт:
- реалізувати зв'язок many-to-many;
- у лікаря може бути лише 10 відкритих записів (одночасно);
- запис автоматично закривається (не видаляється) після того, як лікар напише
користувачеві рекомендацію;
Тестування:
- Потрібно написати для тестового проєкту 3 види тестів model, feature, request.
- Використовувати RSpec та Capybara, бажано factory_bot_rails та faker
- Model. написати тест на валідацію phone_number для моделі Doctor
- Request. перевірити роботу екшену create для будь-якого контролера
- Feature. увійти як лікар і залишити рекомендацію для пацієнта
Загальні вимоги:
- Зробити публічну частину для пацієнтів та лікарів;
- Для реалізації адмінки можна використовувати ActiveAdmin;
- Зображення зберігати на S3 або Cloudinary;
- Викласти код на GitHub;
- Викласти проєкт на Heroku або будь-який інший безкоштовний аналог Heroku
(також, можна використовувати зв'язку VPS + mina/capistrano);
- Надіслати посилання + доступи до адмін частини та публічної частини.
