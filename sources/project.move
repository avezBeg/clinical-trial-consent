module MyModule::ClinicalTrial {

    use aptos_framework::signer;

    /// Represents a clinical trial.
    struct Trial has key, store {
        enrolled: u64,   // Number of patients enrolled
        target: u64,     // Recruitment target
    }

    /// Create a new clinical trial with a recruitment target.
    public fun create_trial(owner: &signer, target: u64) {
        let trial = Trial {
            enrolled: 0,
            target,
        };
        move_to(owner, trial);
    }

    /// Enroll a patient into the trial (increments enrolled count).
    public fun enroll_patient(patient: &signer, trial_owner: address) acquires Trial {
        let trial = borrow_global_mut<Trial>(trial_owner);
        assert!(trial.enrolled < trial.target, 1); // ensure target not exceeded
        trial.enrolled = trial.enrolled + 1;
    }
}
