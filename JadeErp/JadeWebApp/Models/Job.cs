using System;
using System.Collections.Generic;

namespace JadeWebApp.Models
{
    public partial class Job
    {
        public Job()
        {
            Employees = new HashSet<Employee>();
        }

        public byte Id { get; set; }
        public string Name { get; set; } = null!;
        public string? Description { get; set; }
        public bool? Activo { get; set; }

        public virtual ICollection<Employee> Employees { get; set; }
    }
}
