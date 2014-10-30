<div class="view">

	<?php echo GxHtml::encode($data->getAttributeLabel('id')); ?>:
	<?php echo GxHtml::link(GxHtml::encode($data->id), array('view', 'id' => $data->id)); ?>
	<br />

	<?php echo GxHtml::encode($data->getAttributeLabel('photo')); ?>:
	<?php echo GxHtml::encode($data->photo); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('firstname')); ?>:
	<?php echo GxHtml::encode($data->firstname); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('middlename')); ?>:
	<?php echo GxHtml::encode($data->middlename); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('lastname')); ?>:
	<?php echo GxHtml::encode($data->lastname); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('dateofbirth')); ?>:
	<?php echo GxHtml::encode($data->dateofbirth); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('sex')); ?>:
	<?php echo GxHtml::encode($data->sex); ?>
	<br />
	<?php /*
	<?php echo GxHtml::encode($data->getAttributeLabel('type')); ?>:
	<?php echo GxHtml::encode($data->type); ?>
	<br />
	<?php echo GxHtml::encode($data->getAttributeLabel('idmember')); ?>:
		<?php echo GxHtml::encode(GxHtml::valueEx($data->idmember0)); ?>
	<br />
	*/ ?>

</div>