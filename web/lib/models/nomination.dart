
class Nomination {

  final String name;
  final String email;
  final String motivazione;
  final DateTime data;
  final NominationStatus status;


  Nomination({
    this.name,
    this.email,
    this.motivazione,
    this.data,
    this.status
  });

}

enum NominationStatus{
  PENDENTE,
  ACCEPTED,
  REJECTED
}
