--
-- Contenu de la table `items`
--

INSERT INTO `items` (`id`, `libelle`, `value`, `type`) VALUES
(25, 'Poisson', 5, 2),
(26, 'Corps', 0, 0),
(27, 'Corps traité', 0, 0),
(28, 'Ble', 0, 0),
(29, 'Farine', 0, 0),
(30, 'Pain', 20, 2),
(31, 'Poisson surgelé', 0, 0),
(32, 'Poisson nettoyé', 0, 0),
(33, 'Sushi', 60, 2),
(34, 'Canette de Coca', 80, 1),
(35, 'Grappe de raisin', 2, 2),
(36, 'Raisin', 5, 2),
(37, 'Bouteille de vin', 40, 1),
(38, 'Canne a peche', 0, 0),
(39, 'Poisson grillé', 10, 2);

--
-- Contenu de la table `jobs`
--

INSERT INTO `jobs` (`job_id`, `job_name`, `salary`) VALUES
(1, '👦🏻 Sans Emploi', 0),
(2, '🏊 Nettoyeur de piscine', 250),
(3, '🗑 Éboueur', 250),
(4, '⛏ Mineur', 500),
(5, '🚖 Chauffeur de taxi', 500),
(6, '🚍 Livreur de bois', 500),
(7, '⛽️ Livreur de citerne', 500),
(8, '🚍 Livreur de conteneur', 500),
(9, '🚐 Livreur de médicament', 500),
(10, '👮🏻 Policier', 0),
(11, '⚰️ Fossoyeur', 500),
(12, '⚰️ Préposé à la morgue', 500),
(13, '🚑 Ambulancier', 1250),
(14, '🚜 Fermier', 500),
(15, '🎣 Pécheur', 500),
(16, '🍷 Vigneron', 500);

--
-- Structure de la table `user_appartement`
--

CREATE TABLE `user_appartement` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  `money` int(11) NOT NULL DEFAULT '0',
  `dirtymoney` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Index pour la table `user_appartement`
--
ALTER TABLE `user_appartement`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour la table `user_appartement`
--
ALTER TABLE `user_appartement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
