import 'package:stacked/stacked.dart';

class PoshViewModel extends BaseViewModel {
  final pageIndexes = [0, 1, 2, 3, 4];
  var selectedIndex = 0;
  final pageHeader = [
    "Introduction",
    "Types of Sexual Harassment",
    "Recognizing Sexual Harassment",
    "Reporting Mechanisms",
    "Consequences of Sexual Harassment"
  ];

  final topicText = [
    [
      "Definition of Sexual Harassment",
      'Importance of Addressing Sexual Harassment in Sports',
      'Zero-Tolerance Policy',
    ],
    [
      'Verbal Harassment',
      'Non-Verbal Harassment',
      'Physical Harassment',
      'Online Harassment',
    ],
    [
      'Understanding Inappropriate Behaviour',
      'Identifying Consent',
    ],
    [
      'How to report?',
    ],
    [
      'The possible consequences of sexual harassment include',
    ]
  ];

  final summaryText = [
    [
      "Sexual harassment in sports: Unwelcome behaviour that creates discomfort or intimidation. We're committed to a safe, respectful environment, preventing and addressing any misconduct.",
      "Boosted Mental Well-being: A safe environment minimises stress, fostering players' positive mental health for a focused mindset during matches. \n\nConfidence Uplift: Respectful settings empower players, enhancing confidence for optimal performance without concerns about inappropriate behaviour.\n\nTeam Harmony: Respectful environments encourage healthy competition and collaboration, fostering positive team dynamics.\n\nClear Communication: Open and respectful communication allows players to express themselves without fear, aiding better team coordination and trust.\n\nSustained Commitment: Safety and respect reduce turnover and burnout, ensuring players stay committed for long-term athletic development.",
      "Fostering a Safe Sports Community at Gear Up Club\n\nOur Pledge:\nGear Up Club stands united against sexual harassment. Our zero-tolerance policy ensures a sports environment free from fear or discomfort for every member.\n\nKey Points:\n1. Clear Prohibition: Sexual harassment is strictly prohibited.\n2. Consequences: Severe actions for offenders.\n3. Reporting Mechanisms: Confidential reporting at safespace@gearupclub.in.\n4. Education: Ongoing initiatives for prevention.\n5. Leadership Commitment: Our leaders set the standard.\n\nYour Role:\n- Know the policy.\n- Join awareness programs.\n- Support open communication.\n\nTogether, we ensure Gear Up Club is a safe space where everyone feels valued and free to pursue their passions without harassment.",
    ],
    [
      "Inappropriate comments or jokes that create discomfort can vary based on individual sensitivities and cultural contexts. However, some examples of remarks that are generally considered inappropriate and potentially offensive include:\n1. Sexually Explicit Comments: Comments of a sexual nature that are explicit, graphic, or lewd.\n2. Offensive Humour: Jokes or comments that rely on offensive stereotypes, discrimination, or derogatory language.\n3. Unwanted Advances: Unwelcome or persistent advances, flirtation, or romantic comments.\n4. Body Shaming: Comments about a person's physical appearance, weight, or body shape that may be hurtful or judgmental.\n5. Insensitive Remarks: Comments that make light of sensitive topics, such as personal tragedies, illnesses, or other personal challenges.\n6. Innuendos and Double Entendres: Subtle or indirect references with a sexual or offensive undertone.\n7. Disparaging Comments: Remarks that belittle, mock, or insult an individual based on their gender, race, ethnicity, religion, or other personal characteristics.\n8. Unwanted Personal Questions: Intrusive or personal questions that make someone uncomfortable, especially about their private life.\n9. Harassment disguised as \"Jokes\": Comments that may be framed as jokes but are actually a form of harassment, making others feel targeted or demeaned.",
      "Like verbal harassment, gestures can also lead to sexual harassment.  Following are the actions/gestures that are generally considered inappropriate and potentially offensive:\n1. Sexually Suggestive Gestures: The use of explicit or sexually suggestive gestures, motions, or movements that create discomfort or convey inappropriate intentions.\n2. Leering or Staring: Prolonged and inappropriate staring, often accompanied by suggestive facial expressions, directed at an individual in a way that is intimidating or offensive.\n3. Aggressive Physical Proximity: Invading personal space or engaging in aggressive physical proximity with the intention of intimidating or creating discomfort.\n4. Sexualised Taunting or Mimicry: Engaging in taunting, teasing, or mimicry of a sexual nature that targets specific individuals or groups within the sports environment.\n5. Invasion of Personal Space: Persistent and unwarranted invasion of an individual's personal space, creating a sense of discomfort or intimidation.\n6. Sexualised Displays: Displaying sexually explicit images, gestures, or symbols within the sports setting, whether in the locker room, on uniforms, or through other means.\n7. Non-Consensual Recording or Photography: Secretly recording or taking explicit photos of athletes without their consent, violating their privacy and potentially using the material for harassment.",
      'Physical harassment in sports refers to unwelcome and inappropriate physical actions or contact that can cause harm, discomfort, or distress to an individual. This type of harassment can take various forms within the sports context. Examples of physical harassment in sports may include:\n1. Unwanted Touching or Groping: Inappropriate and non-consensual touching or groping of an individual during sports activities, training, or competitions.\n2. Aggressive Physical Altercations: Engaging in aggressive physical behavior, such as pushing, shoving, or intentionally causing harm to another athlete or individual.\n3. Physical Intimidation: Using physical size, strength, or power to intimidate or create fear in another person, whether through aggressive posturing or direct physical threats.\n4. Violent Acts: Acts of violence, including hitting, slapping, punching, or any other form of physical assault, aimed at causing harm or injury.\n5. Locker Room Harassment: Unwanted physical actions or behaviors, such as groping, touching, or intimidation, that occur in locker rooms or changing areas.\n6. Bullying Through Physical Means: Using physical means to bully or harass another athlete, including actions meant to isolate, exclude, or harm the individual physically.\n7. Hazing Rituals: Engaging in initiation practices that involve physical harassment, putting individuals through humiliating or degrading physical activities as a condition of joining a team or group.\n8. Retaliation Through Physical Means: Using physical retaliation or harm in response to an individual reporting harassment or engaging in activities to challenge the harasser.',
      'Online harassment in sports refers to the use of digital platforms and technology to engage in unwelcome and inappropriate behaviour that causes harm, distress, or discomfort to individuals within the sports community. This type of harassment can take various forms, and it often involves the use of social media, messaging apps, or other online channels. Examples of online harassment in sports include:\n1. Cyberbullying: Sending threatening, intimidating, or offensive messages or posts online with the intent to harm or demean players, coaches, or individuals associated with sports.\n2. Hate Speech: Using online platforms to spread discriminatory or hateful language based on an individual\'s race, gender, ethnicity, sexual orientation, or other personal characteristics.\n3. Online Stalking: Persistent and unwanted monitoring of an individual\'s online activities, including tracking their social media posts, comments, and interactions.\n4. False Accusations: Spreading false or defamatory information about players, coaches, or sports personalities with the intent to harm their reputation.\n5. Explicit Content Sharing: Sharing explicit or intimate content without consent, often as a form of revenge or harassment.\n6. Impersonation: Creating fake profiles or impersonating individuals online to deceive or harass them or to damage their reputation.\n7. Doxxing: Publishing private or personal information, such as addresses, phone numbers, or email addresses, online with the intent to cause harm or intimidation.\n8. Trolling: Posting provocative or offensive comments online to elicit strong reactions or to provoke and harass others.\n9. Exclusion and Shaming: Using online platforms to exclude or shame individuals within the sports community, creating a hostile online environment.\n10. Harassment of Officials or Referees: Targeting sports officials or referees with online harassment, including threats, insults, or intimidation related to their on-field decisions.',
    ],
    [
      'Usually, sexual harassment can be unknown to the initiator. It usually starts with a banter which might lead to harassment. Banter refers to a light-hearted and playful teasing or joking among individuals, often within a friendly or familiar context. It becomes inappropriate behaviour when it crosses certain boundaries and becomes unwelcome or offensive. Here are key distinctions:\n1. Consent and Comfort: Banter is typically consensual, and participants are comfortable with the nature of the exchange. Inappropriate behaviour, on the other hand, involves actions that make one or more individuals uncomfortable or distressed.\n2. Intent: Banter is often intended for amusement and mutual enjoyment. Inappropriate behaviour has an intent to cause discomfort, distress, or harm.\n3. Respectful Tone: Banter maintains a respectful and considerate tone, even in teasing. Inappropriate behaviour lacks this consideration and may involve demeaning or offensive language.\n4. Context: Banter is appropriate within the context of the relationship and setting, while inappropriate behaviour disregards appropriate contexts and boundaries.\n5. Power Dynamics: Inappropriate behaviour may involve power imbalances, where one person uses their position to engage in unwelcome actions. Banter typically occurs between equals and doesn\'t exploit power differentials.\n6. Feedback and Boundaries: In banter, participants are responsive to feedback, and boundaries are respected. Inappropriate behaviour persists despite expressed discomfort or objections.\n\nIt\'s important to foster open communication, establish clear boundaries, and ensure that interactions remain respectful and consensual to prevent banter from crossing into inappropriate or harassing territory. Organisations should provide education on recognising and addressing inappropriate behaviour while promoting a positive and respectful culture.',
      'Consent is a fundamental aspect of healthy, respectful, and ethical interactions, especially in the context of relationships, intimacy, and professional settings. In the context of sexual harassment, the importance of obtaining clear and voluntary consent cannot be overstated. Here are key reasons why consent is crucial:\n1. Respect for Autonomy: Consent reflects respect for an individual\'s autonomy and personal boundaries. It acknowledges that everyone has the right to control their own body and make decisions about their own comfort level in various situations.\n2. Prevention of Harassment: Clear and voluntary consent is a critical tool in preventing sexual harassment. It establishes a standard for respectful behavior and helps distinguish between appropriate and inappropriate actions.\n3. Communication and Understanding: Obtaining consent involves open communication and a mutual understanding of each person\'s comfort level. This communication fosters trust and ensures that all parties involved are on the same page regarding the nature of the interaction.\n4. Establishing Boundaries: Consent allows individuals to establish and communicate their boundaries. It creates an environment where people feel empowered to express what they are comfortable with and what is unacceptable.\n5. Avoiding Assumptions: Relying on assumptions about someone\'s willingness to engage in a particular activity can lead to misunderstandings and, in some cases, harassment. Seeking and respecting explicit consent helps avoid assumptions and potential harm.\n6. Legal and Ethical Considerations: In many jurisdictions, consent is a legal requirement for any intimate or sexual activity. Respecting these legal boundaries is not only ethical but also crucial in preventing legal consequences related to harassment.\n7. Promoting Healthy Relationships: Consent is a cornerstone of healthy relationships. It ensures that all parties feel valued and respected, contributing to the creation of positive and consensual dynamics.\n8. Informed Decision-Making: Clear and voluntary consent implies that individuals are making informed decisions about their participation in an activity. This informed decision-making process is key to ethical and respectful interactions.\n\nIn summary, obtaining clear and voluntary consent is crucial in preventing sexual harassment as it promotes respect, communication, and the empowerment of individuals. It sets a standard for ethical behavior and contributes to the creation of positive, healthy, and consensual relationships. Organizations and individuals alike should prioritize education and awareness surrounding the significance of consent in preventing harassment and promoting a culture of respect.',
    ],
    [
      'If you have experienced or witnessed any form of sexual harassment and wish to report an incident, we encourage you to use our confidential support email. Reporting is a crucial step in maintaining a safe and respectful environment for everyone. You can drop a mail to safespace@gearupclub.in, describing the incident as accurately and comprehensively as possible. Include dates, times, locations, and any other relevant information.\nRest assured that your report will be handled with the utmost confidentiality. We are committed to maintaining your privacy throughout the investigation process.\n\nGear Up Club strictly prohibits retaliation against individuals who report incidents in good faith. You will be protected from any adverse consequences for coming forward.',
    ],
    [
      '\n1. Civil Lawsuits: Victims can file lawsuits for damages against the harasser and potentially the employer.\n2. Criminal Charges: Serious cases may lead to criminal charges, resulting in fines, probation, or imprisonment.\n3. Employment Consequences: Employers may face fines, penalties, or legal action for failing to address or prevent harassment.\n4. Legal Settlements: Settlements outside of court may involve financial compensation and confidentiality agreements.\n5. Reputation Damage: Negative publicity and reputational harm may result from legal proceedings.\n6. Injunctions: Courts may issue orders to prevent further harassment, including behaviour changes and training.',
    ]
  ];

  final questions = [
    "What is the definition of sexual harassment?",
    "Which of the following is a type of sexual harassment?",
    "Why is recognizing power dynamics important in preventing sexual harassment?",
    "True/False: Reporting mechanisms should be clear and easily accessible.",
    "True/False: Bystander intervention is not encouraged when witnessing inappropriate behavior.",
    "True/False: Sexual harassment has no legal consequences in a sports context.",
    "During a team event, a senior player consistently makes inappropriate comments about a junior player's appearance, making them uncomfortable. What type of sexual harassment is occurring in this scenario?",
    "During a team event, a senior player consistently makes inappropriate comments about a junior player's appearance, making them uncomfortable. What steps should the junior player take to address the situation?",
    "How can promoting inclusivity and diversity contribute to preventing sexual harassment in a sports setting?",
    "In your own words, explain the importance of bystander intervention in preventing sexual harassment.",
  ];

  final answers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> answersProvided = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1];

  void moveToNextPage() {
    if (selectedIndex < pageIndexes.length - 1) {
      selectedIndex++;
      notifyListeners();
    }
  }

  void moveToPreviousPage() {
    if (selectedIndex > 0) {
      selectedIndex--;
      notifyListeners();
    }
  }

  String getHeaderText() {
    return pageHeader[selectedIndex];
  }
}
