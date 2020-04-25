    //DEVOIR 4 

// QUESTION 1 :Créer un Trigger qui restreindra toutes les opérations de manipulation de données sur la table Pilote aux
heures de travail entre 08H et 18H. Ce trigger restreint les ordres DML sur la table Pilote en utilisant
des attributs Conditionnels pour l’insertion, la mise à jour et la suppression et afficher le message
d’erreurs suivant dans les cas où la condition du trigger n’est pas vérifié :

create or replace trigger controleOP
before insert or update or delete on pilote	
for each row
when(extract (hour from systimestamp)<8 and extract (hour from systimestamp)>18 )
begin 
if inserting then raise_application-error(-20501,'Insertion impossible a cette heure' );
elsif updating then raise_application-error(-20502,'Mise a jour impossible a cette heure' );
else raise_application-error(-20502,'Suppression impossible a cette heure' );
end if ;
end;

//QUESTION 2 : Utiliser une table nommée Audit_Pilote_Table, cette table est constituée des colonnes username, timestamp,
id, old_last_name, new_last_name, old_comm, new_comm, old_salary, new_salary). Créer un trigger qui
pour tout ordre DML sur la table PILOTE insérera une ligne d’audit en enregistrant l’ancienne et la nouvelle
valeur du nom, de la commission et salaire.

create table Audit_Pilote_Table
(
username varchar2(15),
dat timestamp,
id number(4),
old_last_name varchar2(15),
new_last_name varchar2(15),
old_comm number(4),
new_comm number(4),
old_salary number(4),
new_salary number(4)
);

//QUESTION 4 : Créer un trigger qui permet de s’assurer que le salaire ne sera jamais augmenté ou réduit de plus de 10%
d’un coup.

create or replace trigger controleOP
before update of sal on pilote
for each row
begin
   if (:new.sal>:old.sal*1,1)or (:new.sal<:old.sal-0,1*:old.sal)
   then 
   raise_application-error(-20503,'le salaire ne peut pas etre reduit de 10%' );
   end if;
   end;
   
//QUESTION 5: Créer un trigger nommé Ajout-pilote qui limite l’ajout d’un nouveau pilote à l’utilisateur ‘SYSTEM’, et qui
génère le message suivant « Utilisateur non autorisé » lorsque cette contrainte est violée

 create trigger ajout_pilote
 before insert on pilote 
 for each row
 when (user<>system);
 begin
 raise_application-error(-20501,'insertion non autorise');
   

