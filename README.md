<p align="center" >
  <img src="" style="max-width: 20%">
</p>

---

<p align="center">
  <img src="https://forthebadge.com/images/badges/built-with-love.svg"/>
  <img src="https://forthebadge.com/images/badges/made-with-java.svg"/>
  <img src="https://forthebadge.com/images/badges/powered-by-coffee.svg"/><br><br>
    <b>Sogniario</b>, progetto realizzato in <b>Flutter</b> e <b>Spring</b> per il corso di laurea <b>L-31</b> presso <b>Unicam</b>, <i>nell'anno accademico 2020/2021</i>, realizzato dal team Morpheus composto dagli studenti Giorgio Paoletti e Flavio Pocari per l'esame <b>Project</b>.
    <br><br><b>
<a href="https://www.unicam.it/">• Unicam</a>
<a href="https://github.com/GiorgioPaoletti-Unicam/sogniario">• Sogniario</img></a>
</b></p>

# 📔 Tabella dei contenuti

- [Panoramica e funzionalità](#panoramica)
- [Processo di sviluppo](#processo)
- [Tecnologie utilizzate](#tecno)
- [Autori](#autori)

# 📝 Panoramica e funzionalità <a name = "panoramica"></a>

# ⚙ Processo di Sviluppo<a name = "processo"></a>

Per sviluppare l'applicativo è stato scelto di seguire il processo standardizzato **Unified Process (UP)**, processo iterativo incrementale, utilizzando come strumento di lavoro **Visual Paradigm** basato sul **Unified Modeling Language (UML)**.

Attualmente sono state svolta un'iterazione dove è stato possibile effettuare l'analisi dei requisiti, la progettazione del sistema, l'implementazione.

Come strumento di versioning è stato utilizzato **Git** attraverso il quale sono stati distinti die brach per sviluppo.
- master: utilizzato per pubblicare la baseline (artefatti) sviluppati a fine iterazione.
- develop: utilizzato per lo sviluppo fino alla terza iterazione in corrispondenza alla consegna per Ingegneria del Software.

Le varie iterazioni hanno dato origine ai seguenti artefatti:
- Diagramma dei casi d'uso: raccolta e specifica dei requisiti e funzionalità del sistema.
- Diagramma classi di analisi: identificano i concetti che è necessario il sistema rappresenti e sia capace di manipolare.
- Diagrammi di sequenza: descrivono come le classi di analisi interagiscono tra di loro per realizzare il comportamento definito nei casi d'uso.
- Diagramma classi di progetto: realizzato sfruttando il principio LRG (Low Representational Gap) per derivare le classi di progetto partendo dalle classi di analisi, il diagramma verrà utilizzato per le attività di implementazione.
- Code Base

# 🧰 Tecnologie utilizzate<a name = "tecno"></a>

Il lato back end si basa sul linguaggio **Java** e rende disponibile per l'interazione delle **Api Rest**, la cui scrittura e gestione, anche sotto l'ottica della sicurezza, sono state rese possibili grazie al framework **Spring Boot**. Per il building automatizzato del sistema si è impiegato il tool **Gradle**. Inoltre, poter rendere più agevole la scrittura del codice tramite l'uso di annotazioni, si è deciso di impiegare la libreria Java **Lombok**.

Per quanto concerne la persistenza delle informazioni processate a livello di back end si è deciso di sfruttare i servizi offerti dal DBMS non relazionale **MongoDB** e dal relativo framework per linguaggio Java.

Il front end è interamente scritto utilizzando il framework **Flutter**. L'applicativo si sostanzia in un app mobile Nativa per gli ambienti IOS e Android.

# 🔭 Autori <a name = "autori"></a>

- [Giorgio Paoletti](https://github.com/GiorgioPaoletti-Unicam)
- [Flavio Pocari](https://github.com/flaviopopoff)
